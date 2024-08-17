{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
    };
  };

  outputs = { self, nixpkgs, nixos-cosmic, home-manager, catppuccin }: {
    nixosConfigurations = {
      tiny-stars = nixpkgs.lib.nixosSystem {
        modules = [
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kraust = {
              imports = [
                catppuccin.homeManagerModules.catppuccin
              ];
            };
          }
          nixos-cosmic.nixosModules.default
          home-manager.nixosModules.home-manager
          catppuccin.nixosModules.catppuccin
          ./configuration.nix
        ];
      };
    };
  };
}
