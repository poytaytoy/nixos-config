{ pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (ps: with ps; [
      rustup
      zlib
      #openssl.dev
      pkg-config
    ]);

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
      eugleo.magic-racket
      rust-lang.rust-analyzer
    ];
  };

   xdg.configFile."Code/User/settings.json".enable = false;
}