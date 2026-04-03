{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
    copyparty.url = "github:9001/copyparty";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      disko,
      copyparty,
    }:
    let
      system = "aarch64-linux";
      pkgs = import nixpkgs { inherit system; };
      pkgs-unstable = import nixpkgs-unstable { inherit system; };
    in
    {
      homeConfigurations = {
        "kdebre" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit pkgs-unstable;
          };
          modules = [
            ./items/google-trogdor.nix
          ];
        };
      };
      nixosConfigurations = {

        bjueld-da = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            pkgs-unstable = import nixpkgs-unstable {
              config.allowUnfree = true;
              inherit system;
            };
          };
          modules = [
            ./bjuelds/bjueld-da.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.kdebre = import ./items/bjueld-da.nix;
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

        bjueld-of = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            pkgs-unstable = import nixpkgs-unstable {
              config.allowUnfree = true;
              inherit system;
            };
          };
          modules = [
            ./bjuelds/bjueld-of.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.kdebre = import ./items/bjueld-da.nix;
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

        workstation = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [
            ./bjuelds/workstation.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.kdebre = import ./items/workstation.nix;
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

        vps = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            pkgs-unstable = import nixpkgs-unstable {
              # package set (nix attrset), not a path
              config.allowUnfree = true;
              inherit system;
            };
          };
          modules = [
            ./bjuelds/vps.nix
            disko.nixosModules.disko
            # "${nixpkgs-unstable}/nixos/modules/services/misc/shoko.nix"
            # nixpkgs-unstable.nixosModules.services.misc.shoko
            home-manager.nixosModules.home-manager
            copyparty.nixosModules.default
            {
              nixpkgs.overlays = [ copyparty.overlays.default ];
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.kdebre = import ./items/common-cli.nix;
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

        htpc = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            pkgs-unstable = import nixpkgs-unstable {
              config.allowUnfree = true;
              inherit system;
            };
          };
          modules = [
            ./bjuelds/htpc.nix
            "${nixpkgs-unstable}/nixos/modules/services/misc/shoko.nix"
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.kdebre = import ./items/common-cli.nix;
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

        # nix build .#nixosConfigurations.exampleIso.config.system.build.isoImage
        custom-iso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./bjuelds/custom-iso.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.kdebre = import ./items/custom-iso.nix;
            }
          ];
        };
      };
    };
}
