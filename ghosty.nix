{ inputs, ... }:

{
  inputs.ghostty = {
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
        # Split navigation (ctrl + wasd)
        "ctrl+a=goto_split:left"
        "ctrl+s=goto_split:bottom"
        "ctrl+w=goto_split:top"
        "ctrl+d=goto_split:right"

        # Split creation (ctrl + shift + wasd)
        "ctrl+shift+a=new_split:left"
        "ctrl+shift+s=new_split:down"
        "ctrl+shift+w=new_split:up"
        "ctrl+shift+d=new_split:right"

        # Misc
        "super+shift+enter=new_split:auto"
        "super+shift+i=inspector:toggle"
        "super+shift+r=reload_config"
        "ctrl+t=new_tab"
        "ctrl+shift+q=close_tab"
        "ctrl+q=close_surface"
      ];
    };
  };
}