{ config, pkgs, ...}: {

    imports = [
        ./modules/bundle.nix
    ];

    home = {
            username = "rafag00";
            homeDirectory = "/home/rafag00";
            stateVersion = "25.05";
    };

}
