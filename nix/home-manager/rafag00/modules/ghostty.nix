{
  programs.ghostty = {
    enable = true;

    enableBashIntegration = true;

    settings = {
      theme = "noctalia";
      window-decoration = true;
      window-inherit-working-directory = true;
      #window-theme = "dark";
      window-save-state = "always";
      shell-integration = "bash";

      # Mouse settings
      mouse-hide-while-typing = true;
      #copy-on-select = clipboard;
      focus-follows-mouse = true;

      #Other settings;
      clipboard-trim-trailing-spaces = true;

      # Font and cursor settings;
      font-family = "JetBrains Mono Nerd Font";
      font-size = 10;
      cursor-style = "bar";
      cursor-style-blink = true;
      #alt+click;
      cursor-click-to-move = true;
      shell-integration-features = "no-cursor";

      keybind = [
        "alt+shift+up=resize_split:up,10"
        "alt+shift+down=resize_split:down,10"
        "alt+shift+right=resize_split:right,10"
        "alt+shift+left=resize_split:left,10"
        "alt+shift+plus=equalize_splits"
        "alt+s>up=new_split:up"
        "alt+s>down=new_split:down"
        "alt+s>right=new_split:right"
        "alt+s>left=new_split:left"
        "ctrl+w=close_surface"
        "alt+s>z=toggle_split_zoom"
      ];
    };
  };
}
