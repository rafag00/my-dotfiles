{config, ...}: {
  services.vicinae = {
    enable = true; # default: false
    systemd = {
      enable = true; # default: false
      autoStart = true; # default: false
      environment = {
        USE_LAYER_SHELL = 1;
      };
    };
  };

  xdg.dataFile."vicinae/themes/afterburner.svg".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/rafag00/extra/afterburner.svg";

  xdg.dataFile."vicinae/themes/afterburnerDark.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/rafag00/modules/vicinae/afterburnerDark.toml";

  xdg.dataFile."vicinae/themes/afterburnerLight.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/rafag00/modules/vicinae/afterburnerLight.toml";
}
