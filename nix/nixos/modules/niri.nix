{pkgs, lib, config,... }: {

  config = lib.mkIf config.home-manager.users.rafag00.programs.niri.enable {
    programs.niri.enable = true;

    environment.variables.NIXOS_OZONE_WL = "1";

    environment.systemPackages = with pkgs; [
      rofi-wayland
      waybar
      mako # Notifications
      gnome-keyring # Keyring
      xwayland-satellite # XWayland support
      #grim + slurp + swappy # Screenshot tools
      swaybg # Background setting
      wlsunset # Automatic screen brightness
      swaylock # Lock screen
      #stylix # Colorscheme and wallpaper

      # wl-clipboard
      # wayland-utils
    ];
    
  };

}