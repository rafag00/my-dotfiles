{
  # Don't forget to go to https://github.com/Keyitdev/sddm-astronaut-theme for configuring the theme.
  # Go to the /usr/share/sddm/themes/sddm-astronaut-theme/Themes/astronaut.conf and add the Owl background.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    autoNumlock = true;
    theme = "sddm-astronaut-theme";
    settings = {
        Theme = {
          ThemeDir = "/usr/share/sddm/themes/";
        };
    };
  };
}