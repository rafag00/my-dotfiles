{
    description = "System configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    };

    outputs = { nixpkgs, home-manager, nix-flatpak, ... }:
        let
            system = "x86_64-linux";
        in {
            nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
                inherit system;
                modules = [ 
                    nix-flatpak.nixosModules.nix-flatpak
                    ./nixos/configuration.nix 
                    ./nixos/flatpak.nix
                ];
            };

            homeConfigurations.rafag00 = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.${system};
                modules = [ ./home-manager/home.nix ];
            };

        };
}
