{
  inputs,
  pkgs,
  system,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
    inputs.vicinae.homeManagerModules.default
    ./modules
  ];

  home.stateVersion = "25.05";
}
