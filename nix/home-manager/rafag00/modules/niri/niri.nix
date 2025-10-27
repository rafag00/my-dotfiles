{config, pkgs, ...}:
let
    shellChosen = "noctalia";
    shellCommand =
        if shellChosen == "noctalia" then
            ''"noctalia-shell" "ipc" "call"''
        else if shellChosen == "dms" then
            ''"dms" "ipc" "call" "spotlight" "toggle"''
        # waybar or default
        else
            ''"noctalia-shell" "ipc" "call"'';
    
    # read the template file
    template = builtins.readFile ./${shellChosen + "-config.help"};

    # choose a unique placeholder to avoid accidental matches
    placeholders = [ "@shellCommand@" ];
    replacements = [ shellCommand ];

    # perform replacements
    finalConfig = builtins.replaceStrings placeholders replacements template;
in
{
    home.packages = with pkgs; [
        niri
        udiskie
        xwayland-satellite
        nautilus # need to open some dialog windows
        gnome-keyring
        kdePackages.polkit-kde-agent-1
        kdePackages.qt6ct
    ];

    xdg.configFile."niri/config.kdl".text = finalConfig;

    # XWayland satellite service for X11 app support
    systemd.user.services.xwayland-satellite = {
        Unit = {
        Description = "Xwayland outside Wayland";
        BindsTo = "graphical-session.target";
        After = "graphical-session.target";
        };
        Service = {
        Type = "notify";
        NotifyAccess = "all";
        ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
        StandardOutput = "journal";
        Restart = "on-failure";
        };
        Install.WantedBy = [ "graphical-session.target" ];
    };
}