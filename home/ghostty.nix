{ ... }:

{
  programs.ghostty = {
    enable = true;

    settings = {
      # Color scheme — Monokai Classic
      # Based on Monokai Pro, made by Monokai. https://monokai.pro/
      window-colorspace = "srgb";
      background = "272822";
      foreground = "fdfff1";
      cursor-color = "c0c1b5";
      selection-background = "57584f";
      selection-foreground = "fdfff1";

      palette = [
        "0=272822"
        "1=f92672"
        "2=a6e22e"
        "3=e6db74"
        "4=fd971f"
        "5=ae81ff"
        "6=66d9ef"
        "7=fdfff1"
        "8=6e7066"
        "9=f92672"
        "10=a6e22e"
        "11=e6db74"
        "12=fd971f"
        "13=ae81ff"
        "14=66d9ef"
        "15=fdfff1"
      ];

      # Key bindings
      keybind = [
        # Split navigation (ctrl + hjkl)
        "ctrl+h=goto_split:left"
        "ctrl+j=goto_split:bottom"
        "ctrl+k=goto_split:top"
        "ctrl+l=goto_split:right"

        # Split creation (ctrl + shift + hjkl)
        "ctrl+shift+h=new_split:left"
        "ctrl+shift+j=new_split:down"
        "ctrl+shift+k=new_split:up"
        "ctrl+shift+l=new_split:right"

        # Tab navigation (ctrl + alt + arrow)
        "alt+left=previous_tab"
        "alt+right=next_tab"
        
        # Misc
        "super+shift+enter=new_split:auto"
        "super+shift+i=inspector:toggle"
        "super+shift+r=reload_config"
        "ctrl+t=new_tab"
        "ctrl+w=close_surface"
        "ctrl+shift+w=close_tab"
        "ctrl+q=quit"
      ];
    };
  };
}