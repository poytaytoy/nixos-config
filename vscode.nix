{ pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (ps: with ps; [
      rustup
      zlib
      openssl.dev
      pkg-config
    ]);

    userSettings = {
      "workbench.colorTheme" = lib.mkForce "Monokai";
      "files.autoSave" = "afterDelay";
    };

    extensions = with pkgs.vscode-extensions; [
      aaron-bond.better-comments
      bbenoist.nix
      github.copilot
      github.copilot-chat
      haskell.haskell
      jnoortheen.nix-ide
      justusadam.language-haskell
      ms-vscode-remote.remote-containers
      myriad-dreamin.tinymist
    ];
  };
}