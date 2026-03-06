{ pkgs, ... }:
{

  # ==========================================================================
  # SERVICES
  # ==========================================================================

  services.ollama.enable = true;

  # ==========================================================================
  # GAMING
  # ==========================================================================

  programs.gamemode.enable = true;
  programs.kdeconnect.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
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
      "gamemode"
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
      cd = "z";
    };
  };

  programs.starship.enable = true;
  programs.bat.enable = true;

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  environment.systemPackages = with pkgs; [ eza ];

  # ==========================================================================
  # DESKTOP SESSION
  # ==========================================================================

  programs.regreet.enable = true;
  programs.hyprland.enable = true;
}
