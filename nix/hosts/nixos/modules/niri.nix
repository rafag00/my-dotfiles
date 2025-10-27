{pkgs, lib, config, inputs, username, ... }: {
  
  options = {
    niri.enable = lib.mkEnableOption "Niri desktop environment";
  };

  config = lib.mkIf config.niri.enable {

    programs.niri.enable = true; 
    programs.niri.package = pkgs.niri;
    # Ensure niri session is available to display manager
    services.displayManager.sessionPackages = [ pkgs.niri ];

    services = {
      fstrim.enable = true; # SSD Optimizer
      gvfs.enable = true; # For Mounting USB & More
      blueman.enable = true; # Bluetooth Support
      tumbler.enable = true; # Image/video preview
      gnome.gnome-keyring.enable = true;
      upower.enable = true; # Power management (required for DMS battery monitoring)
      
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        wireplumber.enable = true;  # Enable WirePlumber session manager
      };

    };
    
    security.pam.services.sddm.enableGnomeKeyring = true;

    # Needed for dolphin to work
    environment.etc."xdg/menus/applications.menu".source = "/etc/profiles/per-user/${username}/etc/xdg/menus/plasma-applications.menu";
  };
}