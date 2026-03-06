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

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
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
      spicetify-nix,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # --- Core ---
          ./hardware-configuration.nix
          ./fix.nix
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

              sharedModules = [
                inputs.spicetify-nix.homeManagerModules.default
              ];
            };
          }
        ];
      };
    };
}
