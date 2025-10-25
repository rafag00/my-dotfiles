{pkgs, lib, config, inputs, ... }: {
  
  # imports = [
  #   inputs.niri-flake.nixosModules.niri
  #   {
  #       nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];
  #       niri-flake.cache.enable = true;
  #   }
  # ];
  
  options = {
    niri.enable = lib.mkEnableOption "Niri desktop environment";
  };

  config = lib.mkIf config.niri.enable {

    programs.niri.enable = true; 
    programs.niri.package = pkgs.niri;
    # Ensure niri session is available to display manager
    services.displayManager.sessionPackages = [ pkgs.niri ];

  };
}