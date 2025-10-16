{pkgs, lib, ... }: {
  programs.niri.enable = true; 
  programs.niri.package = pkgs.niri-stable;


  environment.systemPackages = with pkgs; [
    #TO-Do
    xwayland-satellite
  ];
}