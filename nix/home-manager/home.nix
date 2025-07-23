{ config, pkgs, ...}: {

    imports = [
        ./modules/bundle.nix
    ];


    home = {
        stateVersion = "25.05";
    };

}
