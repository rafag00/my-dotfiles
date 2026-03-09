{inputs, ...}: {
  imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

  services.flatpak = {
    enable = true;
    update.onActivation = true;

    packages = [
      "com.spotify.Client"
      "dev.vencord.Vesktop"
      "eu.betterbird.Betterbird"
      "com.rtosta.zapzap"
      "com.github.emmanueltouzery.projectpad"
      "com.github.IsmaelMartinez.teams_for_linux"
    ];
  };
}
