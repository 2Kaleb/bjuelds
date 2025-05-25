{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    home-manager={
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
      disko={
      url = "github:nix-community/disko";
  inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self,nixpkgs,nixpkgs-unstable,home-manager,disko,nixos-hardware }: {
    nixosConfigurations ={

    gigabyte-a620i = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        ./hosts/gigabyte-a620i.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kdebre = import ./home-manager/gigabyte-a620i.nix;
            # home-manager.extraSpecialArgs={
            #   pkgs-unstable= import nixpkgs-unstable {
            #    config.allowUnfree = true;
            #   inherit system;
            # };
            # };
         }
      ];
    };

      # Use this for all other targets
      # nixos-anywhere --flake .#generic --generate-hardware-config nixos-generate-config ./hardware-configuration.nix <hostname>
     servitro = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./hosts/servitro.nix
          # ./hardware-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kdebre = import ./home-manager/servitro.nix;
         }
        ];
      };


    thinkbook = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        ./hosts/thinkbook.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kdebre = import ./homes/thinkbook.nix;
            home-manager.extraSpecialArgs={
              pkgs-unstable= import nixpkgs-unstable {
               config.allowUnfree = true;
              inherit system;
            };
         };
          }
      ];
    };

    biostar-a68n-5000 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/biostar-a68n-5000.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kdebre = import ./home.nix;
         }
      ];
    };

    custom-iso = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
          # nix build .#nixosConfigurations.exampleIso.config.system.build.isoImage
        ./custom-iso.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.kdebre = import ./home.nix;
          }
      ];
    };

    surface-go-3 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/surface-go-3.nix
        nixos-hardware.nixosModules.microsoft-surface-go
        nixos-hardware.nixosModules.microsoft-surface-common
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.kdebre = import ./home.nix;
          }
      ];
    };



  };
};
}
