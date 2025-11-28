{host, username, ...}:{

    nix = {
        settings = {
            auto-optimise-store = true;
            experimental-features = [
                "nix-command"
                "flakes"
            ];
            substituters = [
                "https://niri.cachix.org"
            ];
            trusted-public-keys = [
                "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
            ];
        };
    };

    programs.nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 4d --keep 3";
        flake = "/home/${username}/nix";
    };

    time.timeZone = "Europe/Lisbon";

    i18n.defaultLocale = "en_US.UTF-8";
    i18n.supportedLocales = ["en_US.UTF-8/UTF-8" "pt_PT.UTF-8/UTF-8"];
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "pt_PT.UTF-8";
        LC_IDENTIFICATION = "pt_PT.UTF-8";
        LC_MEASUREMENT = "pt_PT.UTF-8";
        LC_MONETARY = "pt_PT.UTF-8";
        LC_NAME = "pt_PT.UTF-8";
        LC_NUMERIC = "pt_PT.UTF-8";
        LC_PAPER = "pt_PT.UTF-8";
        LC_TELEPHONE = "pt_PT.UTF-8";
        LC_TIME = "pt_PT.UTF-8";
    };

}