{
  description = "system nixos flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    antigravity-nix = {
          url = "github:jacopone/antigravity-nix";
          inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, antigravity-nix, ... }@inputs: 

    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          ./de/gnome.nix
          inputs.stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.poytaytoy = import ./home.nix;
              home-manager.extraSpecialArgs = { inherit inputs antigravity-nix; };
            }
        ];
      };
    
  };
}
