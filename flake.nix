
{
  description = "NixOS";
  
  inputs = { 
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, home-manager, catppuccin,...}@inputs: {
    nixosConfigurations = {
      sunshine = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./hosts/sunshine/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs self; };

            home-manager.users.ash = {
              imports = [
                catppuccin.homeModules.catppuccin
                ./home/home.nix
              ];
            };
            
          }
        ];
      };
      raindrops = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [];
      };
    };
  };
}
