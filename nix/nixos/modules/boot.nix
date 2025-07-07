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


        # Possible themes:
        #   - Abstract Rings alt
        #   - Blockchain
        #   - Cross HUD
        #   - Owl
        plymouth = {
            enable = true;
            theme = "owl";
            themePackages = with pkgs; [
                # By default we would install all themes
                (adi1090x-plymouth-themes.override {
                selected_themes = [ "owl" ];
                })
            ];
        };

        # Enable "Silent boot"
        consoleLogLevel = 3;
        initrd.verbose = false;
        kernelParams = [
            "quiet"
            "splash"
            "boot.shell_on_fail"
            "udev.log_priority=3"
            "rd.systemd.show_status=auto"
        ];
        
        # Hide the OS choice for bootloaders.
        # It's still possible to open the bootloader list by pressing any key
        # It will just not appear on screen unless a key is pressed
        loader.timeout = 0;

        # Use latest kernel.
        kernelPackages = pkgs.linuxPackages_latest;
    };
}