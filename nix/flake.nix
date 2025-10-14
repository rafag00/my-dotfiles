{
    description = "System configuration";
    nixConfig = {
        extra-substituters = [
            "https://niri.cachix.org"
        ];
        extra-trusted-public-keys = [
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      ];
    };

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

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

        stylix = {
            url = "github:danth/stylix/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

    };

    outputs = { nixpkgs, nixpkgs-unstable, home-manager, nix-flatpak, lanzaboote, niri-flake, stylix, ... }:
        let
            system = "x86_64-linux";
            pkgs = import nixpkgs { inherit system; };
            pkgs-unstable = import nixpkgs-unstable { inherit system; };
        in {
            nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
                inherit system;

                modules = [ 
                    nix-flatpak.nixosModules.nix-flatpak
                    lanzaboote.nixosModules.lanzaboote
                    
                    #stylix.nixosModules.stylix

                    home-manager.nixosModules.home-manager


                    # Add Niri module here
                    {
                      imports = [ niri-flake.nixosModules.niri ];
                      nixpkgs.overlays = [ niri-flake.overlays.niri ];
                      niri-flake.cache.enable = true;
                    }

                   {
                        home-manager = {
                            useGlobalPkgs = true;
                            useUserPackages = true;

                            users.rafag00 = {
                                imports = [
                                    #niri-flake.homeModules.niri
                                    ./home-manager/home.nix
                                ];
                            };
                        };
                    }

                    ./nixos/configuration.nix 
                    ./nixos/flatpak.nix

                ];
            };
        };
}
