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

  #xdg.configFile."noctalia/colorschemes/Afterburner/Afterburner.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/rafag00/modules/noctalia/Afterburner.json";
}
