{
  pkgs,
  lib,
  config,
  inputs,
  username,
  ...
}: {
  options = {
    niri.enable = lib.mkEnableOption "Niri desktop environment";
  };

  config = lib.mkIf config.niri.enable {
    programs.niri.enable = true;
    programs.niri.package = pkgs.niri;
    # Ensure niri session is available to display manager
    services.displayManager.sessionPackages = [pkgs.niri];

    services = {
      fstrim.enable = true; # SSD Optimizer
      gvfs.enable = true; # For Mounting USB & More
      blueman.enable = true; # Bluetooth Support
      power-profiles-daemon.enable = true;
      gnome.gnome-keyring.enable = true;
      upower.enable = true; # Power management (required for DMS battery monitoring)
      tumbler.enable = true; # Thumbnailer service for KDE
      udisks2.enable = true; # For automounting drives
    };

    xdg.portal.config.niri = {
      default = ["gnome" "gtk"];
      "org.freedesktop.impl.portal.ScreenCast" = "gnome";
      "org.freedesktop.impl.portal.Screenshot" = "gnome";
      "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
      "org.freedesktop.impl.portal.FileChooser" = "kde";
    };

    security.pam.services.sddm.enableGnomeKeyring = true;

    # Needed for dolphin to work
    environment.etc."xdg/menus/applications.menu".source = "/etc/profiles/per-user/${username}/etc/xdg/menus/plasma-applications.menu";
  };
}
