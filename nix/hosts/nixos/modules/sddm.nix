{
  username,
  pkgs,
  ...
}: {
  # Don't forget to go to https://github.com/Keyitdev/sddm-astronaut-theme for configuring the theme.
  # Go to the /usr/share/sddm/themes/sddm-astronaut-theme/Themes/astronaut.conf .
  services.displayManager.autoLogin = {
    enable = true;
    user = "${username}";
  };

  services.displayManager.defaultSession = "niri";

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    autoNumlock = true;
    theme = "sddm-astronaut-theme";
    settings = {
      Theme = {
        ThemeDir = "/usr/share/sddm/themes/";
      };

      Autologin = {
        Session = "niri.desktop";
        User = "${username}";
      };

      General = {
        InputMethod = "qtvirtualkeyboard";
      };
    };
    extraPackages = with pkgs; [
      kdePackages.qtsvg
      kdePackages.qtmultimedia
      kdePackages.qtvirtualkeyboard
    ];
  };
}
