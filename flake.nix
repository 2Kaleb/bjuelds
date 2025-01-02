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

    # ghostty = {
    #   url = "github:ghostty-org/ghostty";
    # };
  };

  outputs = inputs@{ nixpkgs,nixpkgs-unstable,home-manager, ... }: {
    # Please replace my-nixos with your hostname
    nixosConfigurations ={

    nixos = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
	 # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {

            # TODO replace ryan with your own username
            home-manager.users.kdebre = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
              pkgs-unstable = import nixpkgs-unstable {
                inherit system;
                config.allowUnfree = true;
              };
            };
         }
      ];
    };

    custom-iso = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
          # nix build .#nixosConfigurations.exampleIso.config.system.build.isoImage
        ./custom-iso.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # TODO replace ryan with your own username
          home-manager.users.kdebre = import ./home.nix;

          # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
      ];
    };



  };
};
}
