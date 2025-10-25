{ inputs, ... }:
{
    imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

    services.flatpak = {
        enable = true;
        update.auto = {
            enable = true;
            onCalendar = "weekly";
        };

        packages = [
            "com.spotify.Client"
            #"io.github.shiftey.Desktop"
        ];

    };
}