{config, ...}: {
  #xdg.configFile."noctalia/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/rafag00/modules/noctalia/settings.json";

  xdg.configFile."noctalia/colorschemes/Afterburner/Afterburner.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/rafag00/modules/noctalia/Afterburner.json";

  xdg.configFile."noctalia/colorschemes/Afterburner/terminal/Afterburner-dark".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/rafag00/modules/noctalia/Afterburner-dark";

  xdg.configFile."noctalia/colorschemes/Afterburner/terminal/Afterburner-light".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/rafag00/modules/noctalia/Afterburner-light";
}
