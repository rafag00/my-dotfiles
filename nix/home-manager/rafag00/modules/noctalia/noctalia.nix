{config, ...}: {
  #xdg.configFile."noctalia/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/rafag00/modules/noctalia/settings.json";

  # Noctalia colors
  xdg.configFile."noctalia/colorschemes/Afterburner/Afterburner.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/rafag00/modules/noctalia/Afterburner.json";

  # Terminal colors trough noctalia
  xdg.configFile."noctalia/colorschemes/Afterburner/terminal/Afterburner-dark".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/rafag00/modules/noctalia/Afterburner-dark";

  xdg.configFile."noctalia/colorschemes/Afterburner/terminal/Afterburner-light".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/rafag00/modules/noctalia/Afterburner-light";

  # KDE colors
  xdg.dataFile."color-schemes/afterburner-dark.colors".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/rafag00/modules/noctalia/afterburner-dark.colors";

  xdg.dataFile."color-schemes/afterburner-light.colors".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/rafag00/modules/noctalia/afterburner-light.colors";
}
