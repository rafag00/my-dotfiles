{inputs, ...}: {
  imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

  services.flatpak = {
    enable = true;
    update.onActivation = true;

    packages = [
      "com.spotify.Client"
      "dev.vencord.Vesktop"
    ];
  };
}
