{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./lenovoThinkpadE16Gen2Intel.nix
    ./hardware-configuration.nix
    ./stylix.nix
    ./nixvim.nix
  ];

  # --- 1. Nix Settings ---
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    flake = "/etc/nixos/";
  };

  # --- 2. Boot & Localization ---
  system.stateVersion = "25.11";

  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
    };
  };

  networking.hostName = "nixos";
  time.timeZone = "Europe/Istanbul";
  i18n.defaultLocale = "en_US.UTF-8";
  console.useXkbConfig = true;
  services.xserver.xkb.layout = "tr";

  # --- 3. User Configuration ---
  users.users.yusuf = {
    isNormalUser = true;
    description = "Yusuf Oğuz";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };
  programs.starship.enable = true;

  # --- 4. Desktop Environment ---
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  programs.regreet.enable = true;
  programs.dconf.enable = true;

  services.gvfs.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.noto
    nerd-fonts.fira-code
  ];

  # --- 5. Software & Games ---
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    extraPackages = with pkgs; [ gamescope ];
  };

  environment.systemPackages = with pkgs; [
    ffmpeg
    brightnessctl
  ];
}
