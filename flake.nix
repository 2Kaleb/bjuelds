{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, disko, solaar }: {
      nixosConfigurations = {

        gigabyte-a620i = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [
            ./hosts/gigabyte-a620i.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.kdebre = import ./home-manager/gigabyte-a620i.nix;
                extraSpecialArgs = {
                  pkgs-unstable = import nixpkgs-unstable {
                    config.allowUnfree = true;
                    inherit system;
                  };
                };
              };
            }
          ];
        };

        asrock-b850i = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [
            ./hosts/asrock-b850i.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.kdebre =
                import ./home-manager/gigabyte-a620i.nix;
            }
          ];
        };

        workstation = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [
            ./hosts/workstation.nix
            solaar.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.kdebre = import ./home-manager/workstation.nix;
                extraSpecialArgs = {
                  pkgs-unstable = import nixpkgs-unstable {
                    config.allowUnfree = true;
                    inherit system;
                  };
                };
              };
            }
          ];
        };

        servitro = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./hosts/servitro.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.kdebre = import ./home-manager/servitro.nix;
            }
          ];
        };

        # nix build .#nixosConfigurations.exampleIso.config.system.build.isoImage
        custom-iso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/custom-iso.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.kdebre = import ./home-manager/custom-iso.nix;
            }
          ];
        };
      };
    };
}
