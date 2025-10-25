{ pkgs, lib, config, ... }: {
    options = {
        plasma.enable = lib.mkEnableOption "Plasma 6 desktop environment";
    };

    config = lib.mkIf config.plasma.enable {
        services.desktopManager.plasma6.enable = true;

        xdg.portal.extraPortals = with pkgs; [
            kdePackages.xdg-desktop-portal-kde
            libsForQt5.xdg-desktop-portal-kde
        ];

        environment.systemPackages = with pkgs; [
            xdg-utils
            xdg-desktop-portal
            xdg-desktop-portal-gtk
            kdePackages.xdg-desktop-portal-kde
            libsForQt5.xdg-desktop-portal-kde
        ];

        # environment.sessionVariables = {
        #   XDG_SESSION_TYPE = "wayland";
        #   XDG_CURRENT_DESKTOP = "KDE";
        #   XDG_SESSION_DESKTOP = "KDE";
        #   GTK_USE_PORTAL = "1";
        #   NIXOS_XDG_OPEN_USE_PORTAL = "1";
        # };

        # Enable touchpad support (enabled default in most desktopManager).
        #services.libinput.enable = true;
    };
}

    


