{
  description = "My system configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    wallust.url = "git+https://codeberg.org/explosion-mental/wallust?ref=dev";
   #hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; # unstable hyprland
   #ags.url = "github:Aylur/ags"; 
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }@inputs:

    let
      system = "x86_64-linux";

      # User Variables
      hostname = "BathyScarfOS";
      username = "bathys";
      gitUsername = "bathys";
      gitEmail = "nishimua7802@gmail.com";
      theme = "rose-pine";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in {

      nixosConfigurations = {
        "${hostname}" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit inputs;
            inherit username;
            inherit hostname;
            inherit gitUsername;
            inherit gitEmail;
          };
          modules = [
            ./nixos/configuration.nix
            inputs.nixvim.nixosModules.nixvim
            inputs.disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit username;
                inherit gitEmail;
                inherit inputs;
                inherit gitUsername;
                inherit theme;
                inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.${username} = import ./home-manager/home.nix;
            }
          ];
        };
      };
    };
  }