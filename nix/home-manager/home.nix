{ inputs, pkgs, ...}:
{
  imports = [
    #inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    #inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
    inputs.noctalia.homeModules.default
    ./modules/bundle.nix
  ];

  home.stateVersion = "25.05";
        
}
