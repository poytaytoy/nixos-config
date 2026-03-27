{ pkgs, ... }:

{
  home.packages = with pkgs.gnomeExtensions; [
    blur-my-shell
    dash-to-dock
    vitals
    logo-menu
    space-bar
    open-bar
    freon 
    day-progress
    freon 
    net-speed
    media-controls 
  ];
}