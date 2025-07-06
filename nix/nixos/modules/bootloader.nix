{
        # Use the systemd-boot EFI boot loader.
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;
        boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/ac230ddf-ef55-4dd9-9d78-9d37c7dd6f98";
}
