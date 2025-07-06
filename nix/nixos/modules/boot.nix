{ pkgs, lib, ...}: {
    boot = {
        loader.systemd-boot.enable = lib.mkForce false;
        
        lanzaboote = {
            enable = true;
            pkiBundle = "/var/lib/sbctl";
        };

        initrd.systemd.enable = true;  # For auto unlock
        #loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true;
        
        initrd.luks.devices.cryptroot ={
            device = "/dev/disk/by-uuid/ac230ddf-ef55-4dd9-9d78-9d37c7dd6f98";
            crypttabExtraOpts = [ "tpm2-device=auto" "tpm2-measure-pcr=yes" ];
        };

        #boot.plymouth.enable = true;



        # Use latest kernel.
        kernelPackages = pkgs.linuxPackages_latest;
    };
}