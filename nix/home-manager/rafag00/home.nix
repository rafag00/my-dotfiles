{
  inputs,
  pkgs,
  system,
  ...
}: {
  imports = [
    ./modules
  ];

  home.stateVersion = "25.11";
}
