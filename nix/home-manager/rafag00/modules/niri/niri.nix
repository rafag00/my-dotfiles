{
  config,
  pkgs,
  ...
}: let
  shellChosen = "noctalia";
  shellCommand =
    if shellChosen == "noctalia"
    then ''"noctalia-shell" "ipc" "call"''
    else if shellChosen == "dms"
    then ''"dms" "ipc" "call" "spotlight" "toggle"''
    # waybar or default
    else ''"noctalia-shell" "ipc" "call"'';

  # read the template file
  template = builtins.readFile ./${shellChosen + "-config.kdl"};

  # choose a unique placeholder to avoid accidental matches
  placeholders = ["@shellCommand@"];
  replacements = [shellCommand];

  # perform replacements
  finalConfig = builtins.replaceStrings placeholders replacements template;
in {
  home.packages = with pkgs; [
    xwayland-satellite
    nautilus # need to open some dialog windows
    networkmanagerapplet
    wl-clipboard
    cliphist
    gnome-keyring
    kdePackages.polkit-kde-agent-1
    xdg-desktop-portal-gnome
    kdePackages.knewstuff
    kdePackages.ksvg
    kdePackages.qtpositioning
    glib
    #kdePackages.qt6ct
    brightnessctl
    # kdePackages.qtstyleplugin-kvantum
    # libsForQt5.qt5ct
  ];

  #xdg.configFile."niri/config.kdl".text = finalConfig;

  xdg.configFile."niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/rafag00/modules/niri/config.kdl";

  #home.file.".config/dolphinrc".text = ''
  #  [UiSettings]
  #  ColorScheme=*
  #'';

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
    Install.WantedBy = ["graphical-session.target"];
  };

  systemd.user.services.plasma-polkit-agent = {
    Unit = {
      Description = "KDE polkit authentication agent";
      After = ["graphical-session.target"];
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      StandardOutput = "journal";
    };
  };
}
