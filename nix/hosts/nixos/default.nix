{ config, lib, pkgs, inputs, ... }: {

  imports = [
    #stylix.nixosModules.stylix
    ./hardware-configuration.nix
    ./packages.nix
    ./modules
  ];

  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
        xdg-utils
        kdePackages.xdg-desktop-portal-kde
        #libsForQt5.xdg-desktop-portal-kde
      ];
    };
  };


  plasma.enable = true;
  niri.enable = true;

  environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID"; # this is what was missing (in what idk)

  # Enable CUPS to print documents.
  services.printing.enable = true;

  system.stateVersion = "25.05";

}

