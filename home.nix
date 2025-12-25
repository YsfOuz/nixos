{ config, pkgs, lib, ... }:
{
  home.username = "yusuf";
  home.homeDirectory = "/home/yusuf";
  home.stateVersion = "25.11"; # Match your NixOS version

  programs.home-manager.enable = true;

  # ===== USER PACKAGES =====

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Chromium/Electron apps
    MOZ_ENABLE_WAYLAND = "1"; # Firefox
    LIBVA_DRIVER_NAME = "iHD"; # Intel Media Driver for VAAPI
  };

  programs.obs-studio.enable = true;

  home.packages = with pkgs; [
    ollama
    ffmpeg
    # Media
    vlc # Video player
    # Utils
    unzip
    zip

    prismlauncher
    mindustry
    libreoffice
    dconf-editor
  ];

  programs.java.enable = true;

  # ===== GIT =====

  programs.vscode = {
    enable = true;
  };

  programs.spicetify = {
    enable = true;
    windowManagerPatch = true;
  };

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
