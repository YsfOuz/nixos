{
  pkgs,
  lib,
  config,
  ...
}: {
  # ============================================================================
  # GAMING CONFIGURATION
  # ============================================================================
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [proton-ge-bin];
  };

  # ============================================================================
  # USER ACCOUNT
  # ============================================================================
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

  # ============================================================================
  # SHELL & TERMINAL UTILITIES
  # ============================================================================
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.bat.enable = true;

  programs.fzf = {
    keybindings = true;
    fuzzyCompletion = true;
  };

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

  environment.systemPackages = with pkgs; [
    eza
  ];

  # ============================================================================
  # DESKTOP SESSION
  # ============================================================================
  programs.regreet.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
}
