{
  description = "Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    { nixos-hardware
    , self
    , nixpkgs
    , nur
    , home-manager
    , stylix
    , spicetify-nix
    , nixvim
    , ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
          ./user.nix
          ./stylix.nix
          ./nixvim.nix

          # External Modules
          stylix.nixosModules.stylix
          nixvim.nixosModules.nixvim
          nixos-hardware.nixosModules.lenovo-thinkpad-e14-intel-gen6

          # Overlays
          { nixpkgs.overlays = [ nur.overlays.default ]; }

          # Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              backupFileExtension = "backup";

              users.yusuf.imports = [
                ./home.nix
                ./stylix.nix
                ./gnome.nix
                ./firefox.nix
              ];

              sharedModules = [
                spicetify-nix.homeManagerModules.default
              ];
            };
          }
        ];
      };
    };
}
