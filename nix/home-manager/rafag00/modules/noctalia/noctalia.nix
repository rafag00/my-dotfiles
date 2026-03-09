{
  config,
  inputs,
  ...
}: let
  noctalia-afterburner = builtins.readFile ./${"Afterburner.json"};
  ghostty-afterburner-dark = builtins.readFile ./${"Afterburner-dark"};
  ghostty-afterburner-light = builtins.readFile ./${"Afterburner-light"};
in {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  #xdg.configFile."noctalia/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/rafag00/modules/noctalia/settings.json";

  # Noctalia colors - doesn't work
  #xdg.configFile."noctalia/colorschemes/Afterburner/Afterburner.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/rafag00/modules/noctalia/Afterburner.json";
  #xdg.configFile."noctalia/colorschemes/Afterburner/Afterburner.json".text = noctalia-afterburner;

  # Terminal colors trough noctalia - doesn't work
  #xdg.configFile."noctalia/colorschemes/Afterburner/terminal/ghostty/Afterburner-dark".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/rafag00/modules/noctalia/Afterburner-dark";
  #xdg.configFile."noctalia/colorschemes/Afterburner/terminal/ghostty/Afterburner-dark".text = ghostty-afterburner-dark;

  #xdg.configFile."noctalia/colorschemes/Afterburner/terminal/Afterburner-light".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/rafag00/modules/noctalia/Afterburner-light";
  #xdg.configFile."noctalia/colorschemes/Afterburner/terminal/Afterburner-light".text = ghostty-afterburner-light;

  # KDE colors
  xdg.dataFile."color-schemes/afterburner-dark.colors".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/rafag00/modules/noctalia/afterburner-dark.colors";

  xdg.dataFile."color-schemes/afterburner-light.colors".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/home-manager/rafag00/modules/noctalia/afterburner-light.colors";

  #Change script OLD
  #plasma-apply-colorscheme -l | grep -q "* afterburner-dark (current color scheme)" && { plasma-apply-colorscheme afterburner-light; vicinae vicinae://theme/set/afterburnerLight; } || { plasma-apply-colorscheme afterburner-dark; vicinae vicinae://theme/set/afterburnerDark; }

  #Change script
  #[[ "$(readlink -f ~/.local/share/color-schemes/afterburner.colors)" == *"/afterburner-dark.colors" ]] && { ln -sf ~/nix/home-manager/rafag00/modules/noctalia/afterburner-light.colors ~/.local/share/color-schemes/afterburner.colors ; gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'; vicinae vicinae://theme/set/afterburnerLight; } || { ln -sf ~/nix/home-manager/rafag00/modules/noctalia/afterburner-dark.colors ~/.local/share/color-schemes/afterburner.colors; gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'; vicinae vicinae://theme/set/afterburnerDark; }
}
