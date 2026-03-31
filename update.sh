#!/usr/bin/env bash
set -euo pipefail

FLAKE_DIR="$HOME/Documents/nixos-config"
FLAKE_TARGET=".#"   # change to .#hostname if you use a named config

# ── helpers ───────────────────────────────────────────────────────────────────

info()    { echo "==> $*"; }
success() { echo "✓  $*"; }
warn()    { echo "!  $*"; }
die()     { echo "✗  $*" >&2; exit 1; }

check_deps() {
    local missing=()
    command -v nvd          &>/dev/null || missing+=("nvd (nix-community/nvd — for --diff)")
    command -v nix          &>/dev/null || missing+=("nix")
    command -v nixos-rebuild &>/dev/null || missing+=("nixos-rebuild")
    if [[ ${#missing[@]} -gt 0 ]]; then
        warn "Missing optional/required tools:"
        printf '   %s\n' "${missing[@]}"
        echo
    fi
}

stage_git() {
    info "Staging all changes in $FLAKE_DIR"
    cd "$FLAKE_DIR"
    git add .
    git status --short
}

# ── modes ─────────────────────────────────────────────────────────────────────

do_dry_run() {
    info "Dry-run: evaluating config (no switch)"
    cd "$FLAKE_DIR"
    nix build \
        ".#nixosConfigurations.$(hostname).config.system.build.toplevel" \
        --dry-run \
        --no-link \
        2>&1 | tee /tmp/nixos-dry-run.log
    if grep -q "will be fetched" /tmp/nixos-dry-run.log || \
       grep -q "will be built"   /tmp/nixos-dry-run.log; then
        warn "Packages that would be fetched or built:"
        grep -E "will be (fetched|built)" /tmp/nixos-dry-run.log || true
    else
        success "Nothing new to build — config is already up to date"
    fi
}

do_diff() {
    info "Diffing current system vs new closure"
    cd "$FLAKE_DIR"
    command -v nvd &>/dev/null || die "'nvd' not found. Install it: nix profile install nixpkgs#nvd"
    local new_drv
    new_drv=$(nix build \
        ".#nixosConfigurations.$(hostname).config.system.build.toplevel" \
        --no-link \
        --print-out-paths 2>/dev/null)
    nvd diff /run/current-system "$new_drv"
}

do_gc() {
    info "Garbage-collecting old generations"
    echo
    echo "Current generations:"
    sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
    echo
    warn "This will delete all non-current generations."
    read -rp "Continue? [y/N] " yn
    [[ "$yn" =~ ^[Yy]$ ]] || { echo "Aborted."; return; }
    sudo nix-collect-garbage -d
    sudo /run/current-system/bin/switch-to-configuration boot
    success "Garbage collection complete"
    echo
    echo "Remaining generations:"
    sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
}

do_switch() {
    info "Rebuilding and switching to new config"
    cd "$FLAKE_DIR"
    sudo nixos-rebuild switch --flake "${FLAKE_TARGET}"
    success "Switch complete — now running generation $(
        nixos-rebuild list-generations 2>/dev/null | tail -1 | awk '{print $1}' || echo '?'
    )"
}

do_update() {
    info "Updating flake inputs"
    cd "$FLAKE_DIR"
    sudo nix flake update
    success "Flake inputs updated"
}

# ── usage ─────────────────────────────────────────────────────────────────────

usage() {
    cat <<EOF
Usage:  $(basename "$0") [options]

Modes (can be combined, run left-to-right):
  --dry-run     Evaluate the config without switching — shows what would be built/fetched
  --diff        Compare current system packages vs the new closure (requires nvd)
  --gc          Garbage-collect old Nix store generations (prompts for confirmation)
  --switch      Stage git, rebuild, and switch
  --update      Update flake inputs only (no rebuild)

Examples:
  $(basename "$0") --dry-run              # safe eval check
  $(basename "$0") --diff                 # see what changed
  $(basename "$0") --dry-run --diff       # eval + diff before committing
  $(basename "$0") --switch               # full deploy
  $(basename "$0") --gc                   # clean up old generations
  $(basename "$0") --diff --gc --switch   # diff → clean → deploy
EOF
}

# ── main ──────────────────────────────────────────────────────────────────────

[[ $# -eq 0 ]] && { usage; exit 0; }

check_deps

RUN_DRY=0; RUN_DIFF=0; RUN_GC=0; RUN_SWITCH=0; RUN_UPDATE=0

for arg in "$@"; do
    case "$arg" in
        --dry-run) RUN_DRY=1 ;;
        --diff)    RUN_DIFF=1 ;;
        --gc)      RUN_GC=1 ;;
        --switch)  RUN_SWITCH=1 ;;
        --update)  RUN_UPDATE=1 ;;
        --help|-h) usage; exit 0 ;;
        *) die "Unknown option: $arg. Run with --help for usage." ;;
    esac
done

[[ $RUN_UPDATE -eq 1 ]] && do_update
[[ $RUN_DRY    -eq 1 ]] && { stage_git; do_dry_run; }
[[ $RUN_DIFF   -eq 1 ]] && { stage_git; do_diff; }
[[ $RUN_GC     -eq 1 ]] && do_gc
[[ $RUN_SWITCH -eq 1 ]] && { stage_git; do_switch; }

success "Done"