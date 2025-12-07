{ config, pkgs, ... }:

{
  home.username = "yusuf";
  home.homeDirectory = "/home/yusuf";
  home.stateVersion = "25.11";  # Match your NixOS version
  
  programs.home-manager.enable = true;

  # ===== USER PACKAGES =====

  programs.obs-studio.enable = true;

  programs.alacritty = {
    enable = true;
  };

  services.cliphist.enable = true;

  home.packages = with pkgs; [
    # File managers
    yazi          # Terminal file manager
    
    # Media
    mpv           # Video player
    
    # Utils
    unzip
    zip

    prismlauncher
    lmms
    wl-clipboard
    hyprshot
  ];

  programs.java.enable = true;

  # ===== GIT =====

  programs.vscode = {
    enable = true;
  };

  programs.spicetify.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Yusuf Oğuz";
        email = "ysfouz2007@gmail.com";
      };
    };
  };
  # ===== BTOP =====
  
  programs.btop.enable = true;

  # ===== XDG (USER DIRECTORIES) =====
  
  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
