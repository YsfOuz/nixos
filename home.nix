{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    ./hyprland.nix
    ./stylix.nix
    ./firefox.nix
    ./waybar.nix
    ./rofi.nix
  ];

  # --- 1. Session & Meta ---
  home.username = "yusuf";
  home.homeDirectory = "/home/yusuf";
  home.stateVersion = "25.11";

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # --- 2. User Packages ---
  home.packages = with pkgs; [
    # Desktop
    hyprshot
    wl-clipboard
    wl-screenrec
    pavucontrol

    # Development
    jdk
    gcc
    nodejs

    # Apps
    libreoffice
    mindustry
    prismlauncher
  ];

  # --- 3. Services ---
  services.cliphist = {
    enable = true;
    allowImages = true;
  };

  services.network-manager-applet.enable = true;

  # --- 4. CLI Tools ---
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Yusuf Oğuz";
        email = "ysfouz2007@gmail.com";
      };
      credential.helper = "store";
    };
  };

  programs.btop.enable = true;
  programs.fastfetch.enable = true;
  programs.spicetify.enable = true;
  programs.cava.enable = true;

  # --- 5. GUI Applications ---
  programs.alacritty = {
    enable = true;
    settings.window.padding = {
      x = 5;
      y = 5;
    };
  };

  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        ms-vscode.live-server
        ms-vscode.cpptools
        ms-vscode.cmake-tools
        redhat.java
        vscjava.vscode-java-debug
        vscjava.vscode-java-test
        vscjava.vscode-maven
        vscjava.vscode-gradle
        vscjava.vscode-java-dependency
        jnoortheen.nix-ide
      ];
      userSettings = {
        "editor.formatOnSave" = true;
        "files.autoSave" = "afterDelay";
        "editor.smoothScrolling" = true;
        "terminal.integrated.smoothScrolling" = true;
        "workbench.startupEditor" = "none";
        "chat.disableAIFeatures" = true;
        "editor.inlayHints.enabled" = "off";
        "editor.inlineSuggest.enabled" = false;
      };
    };
  };
}
