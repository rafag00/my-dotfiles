{pkgs, lib, config, inputs, ... }: {
  
  imports = [
    inputs.niri-flake.nixosModules.niri
    {
        nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];
        niri-flake.cache.enable = true;
    }
  ];
  
  options = {
    niri.enable = lib.mkEnableOption "Plasma 6 desktop environment";
  };

  config = lib.mkIf config.niri.enable {

    programs.niri.enable = true; 
    programs.niri.package = pkgs.niri-stable;


    environment.systemPackages = with pkgs; [
      #TO-Do
      xwayland-satellite
      nautilus
    ];
  };
}