  { config, pkgs, inputs, de, ... }:

  { 
    imports = let FOLDER = "home"; in
      [
      ./${FOLDER}/ghostty.nix
      ./${FOLDER}/vscode.nix
      ./${FOLDER}/git.nix
      ];


    home.shellAliases = {
      config = "bash ~/Documents/nixos-config/update.sh";
    };

    home.username = "poytaytoy";
    home.homeDirectory = "/home/poytaytoy";
    home.stateVersion = "25.11";

    home.packages =
      with pkgs; [

        # Archives
        zip
        xz
        unzip
        p7zip

        # System Info
        fastfetch
        lshw

        # Version Control
        git
        gh

        # Development
        rust-analyzer
        rustc
        cargo
        racket
        devenv

        # Documents & Typesetting
        texlive.combined.scheme-full
        libreoffice-fresh
        typst
        tinymist

        # AI
        claude-code

        # Media & Communication
        google-chrome
        discord-ptb
        spotify

        # Utilities
        caligula

        (pkgs.wrapOBS {
          plugins = with pkgs.obs-studio-plugins; [
            wlrobs
            obs-backgroundremoval
            obs-pipewire-audio-capture
            obs-vaapi
            obs-gstreamer
            obs-vkcapture
          ];
        })

        prismlauncher 
      ];
  }