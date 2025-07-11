{ pkgs, lib, ...}: {
    boot = {
        loader.systemd-boot.enable = lib.mkForce false;

        lanzaboote = {
            enable = true;
            pkiBundle = "/var/lib/sbctl";
        };


        initrd.systemd.enable = true;  # For auto unlock
        #loader.systemd-boot.enable = true; #disable for auto unlock
        loader.efi.canTouchEfiVariables = true;
        
        initrd.luks.devices.cryptroot ={
            device = "/dev/disk/by-uuid/bfa86569-54c2-465a-b946-0dab5402539a";
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
