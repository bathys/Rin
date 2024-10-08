{
  description = "Rin system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    stylix.url = "github:danth/stylix";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fine-cmdline = {
      url = "github:VonHeikemen/fine-cmdline.nvim";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs:

    let
      system = "x86_64-linux";

      # User Variables
      hostname = "Rin";
      username = "sumelan";
    in
    {
      nixosConfigurations = {
        "${hostname}" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit username;
            inherit hostname;
            inherit inputs;
          };
          modules = [
            ./nixos/configuration.nix
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
              {
              home-manager.extraSpecialArgs = {
                inherit username;
                inherit hostname;
                inherit inputs;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.${username} = {
               imports = [
                  ./home-manager/home.nix
                ];
              };
            } 
          ];
        };
      };
    };
  }
