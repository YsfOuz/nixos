{ pkgs, ... }:
{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # Enables Docker-compatible CLI
  };

  services.open-webui.enable = true;

  # ===== GAMING =====

  programs.gamemode.enable = true;

  programs.gamescope.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };



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
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    shellAliases = {
      ls = "eza --icons -a --group-directories-first";
      tree = "eza --tree --icons";
      cat = "bat";
    };
  };
  programs.starship.enable = true;

  environment.systemPackages = with pkgs; [
    eza
    bat
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.noto
    nerd-fonts.fira-code
  ];

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
  ];
  services.gnome = {
    core-apps.enable = false;
    core-developer-tools.enable = false;
    games.enable = false;
  };
}
