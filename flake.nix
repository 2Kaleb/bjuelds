{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager={
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

  };

  outputs = inputs@{ self,nixpkgs,home-manager }: {
    nixosConfigurations ={

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
  };
};
}
