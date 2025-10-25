{ pkgs, username, inputs, ... }: {

    imports =  [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
        extraSpecialArgs = { inherit inputs; };
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
                "docker"
                "networkmanager" 
                "wheel"
            ];
            packages = with pkgs; [
                # Desktop apps not in home-manager
                docker
                github-desktop
                gnome-text-editor

                # Work apps
                libreoffice
                slack
                teams-for-linux
                zotero
                zoom-us

                #other
                appimage-run # run appimages
                cmatrix # Matrix Movie Effect In Terminal
                cowsay # Great Fun Terminal Program
                killall # For Killing All Instances Of Programs
                quick-webapps
                localsend
            ];
        };

    };

    # Enable automatic login for the user.
    services.getty.autologinUser = "rafag00";
}
