{
  description = "Flake";

  # ============================================================================
  # INPUTS
  # ============================================================================
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

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # ============================================================================
  # OUTPUTS
  # ============================================================================
  outputs = {
    self,
    nixpkgs,
    nur,
    home-manager,
    stylix,
    nixvim,
    spicetify-nix,
    ...
  } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        # --- Core Modules ---
        ./hardware-configuration.nix
        ./configuration.nix
        ./user.nix

        # --- Theming & Editor ---
        ./stylix.nix
        ./nixvim.nix
        stylix.nixosModules.stylix
        nixvim.nixosModules.nixvim

        # --- Overlays ---
        {nixpkgs.overlays = [nur.overlays.default];}

        # --- Home Manager Configuration ---
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {inherit inputs;};
            backupFileExtension = "backup";

            # User Imports
            users.yusuf.imports = [
              ./home.nix
              ./stylix.nix
              ./firefox.nix
              ./hyprland.nix
            ];

            # Shared Modules
            sharedModules = [
              inputs.spicetify-nix.homeManagerModules.default
            ];
          };
        }
      ];
    };
  };
}
