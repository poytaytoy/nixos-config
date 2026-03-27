  { config, pkgs, inputs, ... }:

  {
    imports = let FOLDER = "configs"; in
      [
      ./${FOLDER}/ghostty.nix
      ./${FOLDER}/vscode.nix
      ];

    home.username = "poytaytoy";
    home.homeDirectory = "/home/poytaytoy";

    home.packages = with pkgs; [
      zip
      xz
      unzip
      p7zip
      git
      gh
      fastfetch
      lshw
      google-chrome 
      discord-ptb
      spotify

      #gnome extensions 
      gnomeExtensions.blur-my-shell
      gnomeExtensions.dash-to-dock
      gnomeExtensions.vitals
      gnomeExtensions.logo-menu
      gnomeExtensions.space-bar
      gnomeExtensions.open-bar
      gnome-screenshot
      
      rust-analyzer
      rustc 
      cargo 
      racket 
      texlive.combined.scheme-full
      inputs.antigravity-nix.packages.x86_64-linux.default 
      claude-code
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
      claude-code
      libreoffice-fresh
      typst 
      tinymist 
      caligula 
      devenv
    ];

    programs.git = {
      enable = true;
      userName = "Clement Chung";
      userEmail = "clementcycc8@gmail.com";
    };
    
    home.stateVersion = "25.11";
  }