{ config, lib, pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ./modules/bundle.nix
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  networking.hostName = "nixos"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.supportedLocales = ["en_US.UTF-8/UTF-8" "pt_PT.UTF-8/UTF-8"];

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };


  #MODIFY ACCORDING TO NEW SITE
  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-gnome
        pkgs.kdePackages.xdg-desktop-portal-kde
        pkgs.libsForQt5.xdg-desktop-portal-kde
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    kdePackages.xdg-desktop-portal-kde
    libsForQt5.xdg-desktop-portal-kde
  ];

  # environment.sessionVariables = {
  #   XDG_SESSION_TYPE = "wayland";
  #   XDG_CURRENT_DESKTOP = "KDE";
  #   XDG_SESSION_DESKTOP = "KDE";
  #   GTK_USE_PORTAL = "1";
  #   NIXOS_XDG_OPEN_USE_PORTAL = "1";
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "eu";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Open ports in the firewall.
  #networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.05";

}

