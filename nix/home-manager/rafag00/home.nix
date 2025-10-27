{ inputs, pkgs, system, ...}:
{
  imports = [
    #inputs.quickshell-git.packages.${system}.default
    #inputs.dms.homeModules.dankMaterialShell.default
    #inputs.dms.homeModules.dankMaterialShell.niri
    inputs.noctalia.homeModules.default
    ./modules
  ];

  home.stateVersion = "25.05";
        
}
