{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager={
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

  };

  outputs = inputs@{ self,nixpkgs,nixpkgs-unstable,home-manager }: {
    nixosConfigurations ={

    my-nixos = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
          {
              # Allow insecure package because we have no other solution
              # Can be removed after https://github.com/NixOS/nixpkgs/issues/360592 is closed
              nixpkgs.config.permittedInsecurePackages = [
                 "aspnetcore-runtime-6.0.36"
    "aspnetcore-runtime-wrapped-6.0.36"
    "dotnet-sdk-6.0.428"
    "dotnet-sdk-wrapped-6.0.428"
              ];
            }
        ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
              pkgs-unstable = import nixpkgs-unstable {
                inherit system;
                config.allowUnfree = true;
              };
            };
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
