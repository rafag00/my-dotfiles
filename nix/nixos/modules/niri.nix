{pkgs, lib, ... }: {
  programs.niri.enable = true; 
  programs.niri.package = pkgs.niri-stable;
}