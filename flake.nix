{
  description = "Yusuf's NixOS Flake";

  # ==========================================================================
  # INPUTS
  # ==========================================================================
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # ==========================================================================
  # OUTPUTS
  # ==========================================================================
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stylix,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # --- Core ---
          ./hardware-configuration.nix
          ./configuration.nix
          ./user.nix

          # --- Theming & Editor ---
          stylix.nixosModules.stylix
          ./stylix.nix

          # --- Home Manager ---
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
                ./firefox.nix
                ./hyprland.nix
              ];
            };
          }
        ];
      };
    };
}
