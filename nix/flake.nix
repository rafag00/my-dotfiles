{
    description = "System configuration";

    inputs = {
        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

        lanzaboote = {
            url = "github:nix-community/lanzaboote/v0.4.3";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        noctalia = {
            url = "github:noctalia-dev/noctalia-shell";
            inputs.nixpkgs.follows = "nixpkgs";
        };

    };
    
    outputs = { nixpkgs, nixpkgs-stable, ... } @ inputs:
        let
            system = "x86_64-linux";
            pkgs = import nixpkgs { inherit system; };
            pkgs-stable = import nixpkgs-stable { inherit system; };

            
            mkHost = {hostname, username}: nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = {
                    inherit inputs;
                    host = hostname;
                    inherit username;
                    inherit pkgs-stable;
                    inherit system;
                };
                modules = [./hosts/${hostname}];
            };

        in {
            nixosConfigurations = {
                nixos = mkHost { hostname = "nixos"; username = "rafag00";};
            };

        };
}
