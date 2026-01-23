{
  username,
  pkgs,
  lib,
  inputs,
  ...
}: let
  afterburner = pkgs.fetchurl {
    name = "afterburner.mp4";
    url = "https://motionbgs.com/dl/4k/8388";
    hash = "sha256-IQwWsg6jtTUL6tBBd4fLO0PKoj7brIcCGY+p7/S1liE=";
  };
  avatar = "/home/rafag00/nix/home-manager/rafag00/extra/coolF22.jpg";
  silent-sddm = inputs.silentSDDM.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
    # one of configs/<$theme>.conf
    theme = "rei";
    # aditional backgrounds
    extraBackgrounds = [afterburner];
    # overrides config set by <$theme>.conf
    theme-overrides = {
      "LoginScreen.LoginArea.Avatar" = {
        shape = "circle";
        active-border-color = "#94a3b8";
      };
      "LoginScreen" = {
        background = "${afterburner.name}";
      };
      "LockScreen" = {
        background = "${afterburner.name}";
      };
      "LockScreen.Clock" = {
        color = "#94a3b8";
      };
      "LockScreen.Date" = {
        color = "#94a3b8";
      };
    };
  };
  sddm-theme = silent-sddm;
in {
  # services.displayManager.autoLogin = {
  #   enable = true;
  #   user = "${username}";
  # };

  services.displayManager.defaultSession = "niri";

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = lib.mkForce pkgs.kdePackages.sddm;
    autoNumlock = true;
    theme = sddm-theme.pname;
    settings = {
      General = {
        GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
        InputMethod = "qtvirtualkeyboard";
      };

      # Autologin = {
      #   Session = "niri.desktop";
      #   User = "${username}";
      # };
    };
    extraPackages = with pkgs;
      [
        kdePackages.qtsvg
        kdePackages.qtmultimedia
        kdePackages.qtvirtualkeyboard
      ]
      ++ silent-sddm.propagatedBuildInputs;
  };

  # silent-sddm avatar
  systemd.tmpfiles.rules = let
    user = "${username}";
    iconPath = avatar;
  in [
    "f+ /var/lib/AccountsService/users/${user}  0600 root root -  [User]\\nIcon=/var/lib/AccountsService/icons/${user}\\n"
    "L+ /var/lib/AccountsService/icons/${user}  -    -    -    -  ${iconPath}"
  ];

  environment.systemPackages = [
    silent-sddm
    silent-sddm.test
  ];
}
