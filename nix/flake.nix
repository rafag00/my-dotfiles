{
    description = "System configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

        lanzaboote = {
            url = "github:nix-community/lanzaboote/v0.4.2";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        niri-flake.url = "github:sodiboo/niri-flake";

    };

    outputs = { nixpkgs, home-manager, nix-flatpak, lanzaboote, niri-flake, ... }:
        let
            system = "x86_64-linux";
        in {
            nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
                inherit system;
                modules = [ 
                    nix-flatpak.nixosModules.nix-flatpak
                    lanzaboote.nixosModules.lanzaboote
                    niri-flake.nixosModules.niri
                    ./nixos/configuration.nix 
                    ./nixos/flatpak.nix
                ];
                specialArgs = {
                    inherit niri-flake;
                };
            };

            homeConfigurations.rafag00 = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.${system};
                modules = [ ./home-manager/home.nix ];
            };
        };
}
