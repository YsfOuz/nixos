{ pkgs, ... }:
{

  # ==========================================================================
  # SERVICES
  # ==========================================================================

  services.ollama.enable = true;
  services.searx = {
    enable = true;
    redisCreateLocally = true;
    settings = {
      server = {
        secret_key = "a9f3b1c8d2e7f4a5b6c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0";
      };
      search = {
        formats = [
          "html"
          "json"
        ];
      };
    };
  };

  # ==========================================================================
  # GAMING
  # ==========================================================================

  programs.kdeconnect.enable = true;

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  # ==========================================================================
  # USER
  # ==========================================================================

  users.users.yusuf = {
    isNormalUser = true;
    description = "Yusuf Oğuz";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "render"
    ];
  };

  # ==========================================================================
  # SHELL
  # ==========================================================================

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      fastfetch
    '';
    shellAliases = {
      ls = "eza --icons";
      tree = "eza --tree --icons";
      cat = "bat";
    };
  };

  programs.starship.enable = true;
  programs.bat.enable = true;

  environment.systemPackages = with pkgs; [ eza ];

  # ==========================================================================
  # DESKTOP SESSION
  # ==========================================================================

  programs.regreet.enable = true;
  programs.hyprland.enable = true;
}
