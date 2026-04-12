{
  imports = [
    ./bluetooth.nix
    ./boot.nix
    ./docker.nix
    ./env.nix
    ./flatpak.nix
    ./networking.nix
    ./niri.nix
    ./plasma.nix
    ./sddm.nix
    #./silentSDDM.nix
    ./sound.nix
    ./system.nix
    ./user.nix
    ./xserver.nix
    #./zram.nix # using instead zswap because https://chrisdown.name/2026/03/24/zswap-vs-zram-when-to-use-what.html
    ./zswap.nix
  ];
}
