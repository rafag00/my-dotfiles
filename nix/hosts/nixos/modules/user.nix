{
  pkgs,
  username,
  inputs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = import ../../../home-manager/${username}/home.nix;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.bash;

    users.${username} = {
      isNormalUser = true;
      extraGroups = [
        "i2c"
        "docker"
        "networkmanager"
        "wheel"
      ];
      packages = with pkgs; [
        # Desktop apps
        brave
        docker
        github-desktop
        kdePackages.ghostwriter
        qalculate-qt
        haruna
        keepassxc
        kdePackages.okular
        kdePackages.ark
        kdePackages.gwenview
        kdePackages.filelight

        # Dolphin dependencies
        kdePackages.dolphin
        kdePackages.dolphin-plugins
        kdePackages.baloo-widgets
        kdePackages.baloo
        kdePackages.kimageformats
        kdePackages.kdegraphics-thumbnailers
        kdePackages.ffmpegthumbs
        kdePackages.qtimageformats
        kdePackages.plasma-workspace

        # Coding apps
        vscode
        lazygit
        lazydocker

        # Ipod shuffle
        rhythmbox
        libgpod

        # Work apps
        libreoffice
        slack
        #teams-for-linux
        zotero
        zoom-us

        #other
        cmatrix # Matrix Movie Effect In Terminal
        cowsay # Great Fun Terminal Program
        killall # For Killing All Instances Of Programs
        quick-webapps # Create Webapps From Any Website
        localsend # Easy File Transfer Over LAN
        pywalfox-native # Firefox Theme Changer Based On Pywal
        distrobox # containerized dev environments

        # Development libs
        alejandra
        uv
        devenv
      ];
    };
  };

  #programs.bash.blesh.enable = true;
  programs.direnv = {
    enable = true;
    silent = true;
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "rafag00";
}
