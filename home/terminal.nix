{ pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "z" ];
      theme = "";   # empty — Starship handles the prompt
    };
  };

  # zoxide (the "z foo" directory jumper)
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # A Nerd Font so icons render
  home.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # Stop Stylix from also managing starship.toml (prevents the conflict)
  stylix.targets.starship.enable = lib.mkForce false;

  # Link a raw TOML file straight into ~/.config/starship.toml
  xdg.configFile."starship.toml".source = lib.mkForce ./starship.toml;
}