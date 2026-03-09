{pkgs, ...}: {
  home.packages = [
    (let
      # Reference the package used by the module
      pkg = pkgs.ghostty;
      desktopFileName = "com.mitchellh.ghostty.desktop";
      newIcon = "/home/rafag00/nix/home-manager/rafag00/extra/com.mitchellh.ghostty.svg";
    in
      (pkgs.runCommand "ghostty-icon-fix" {} ''
        mkdir -p $out/share/applications
        substitute ${pkg}/share/applications/${desktopFileName} $out/share/applications/${desktopFileName} \
          --replace-fail "Icon=com.mitchellh.ghostty" "Icon=${newIcon}"
      '').overrideAttrs (_: {
        # Lower number = higher priority. Ensures this .desktop file wins.
        meta.priority = -1;
      }))
  ];

  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;

    settings = {
      theme = "noctalia";
      window-decoration = "server";
      window-inherit-working-directory = true;
      window-save-state = "always";
      shell-integration = "bash";

      # Mouse settings
      mouse-hide-while-typing = true;
      focus-follows-mouse = true;

      # Other settings
      clipboard-trim-trailing-spaces = true;

      # Font and cursor settings
      font-family = "JetBrains Mono Nerd Font";
      font-size = 10;
      cursor-style = "bar";
      cursor-style-blink = true;
      cursor-click-to-move = true;
      shell-integration-features = [
        "no-cursor"
        "ssh-env"
      ];

      keybind = [
        "alt+s>up=new_split:up"
        "alt+s>down=new_split:down"
        "alt+s>right=new_split:right"
        "alt+s>left=new_split:left"

        "alt+up=goto_split:up"
        "alt+down=goto_split:down"
        "alt+right=goto_split:right"
        "alt+left=goto_split:left"

        "alt+ctrl+shift+up=resize_split:up,10"
        "alt+ctrl+shift+down=resize_split:down,10"
        "alt+ctrl+shift+right=resize_split:right,10"
        "alt+ctrl+shift+left=resize_split:left,10"
        "alt+ctrl+shift+plus=equalize_splits"

        "alt+w=close_surface"
        "alt+s>z=toggle_split_zoom"

        "alt+shift+up=adjust_selection:up"
        "alt+shift+down=adjust_selection:down"
        "alt+shift+right=adjust_selection:right"
        "alt+shift+left=adjust_selection:left"
        "alt+shift+home=adjust_selection:home"
        "alt+shift+end=adjust_selection:end"
        "alt+shift+page_up=adjust_selection:page_up"
        "alt+shift+page_down=adjust_selection:page_down"

        "alt+end=scroll_to_bottom"
        "alt+home=scroll_to_top"
        "alt+page_up=scroll_page_up"
        "alt+page_down=scroll_page_down"
      ];
    };
  };
}
