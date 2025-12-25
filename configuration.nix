{ config, pkgs, ... }:

{
  # ===== BOOTLOADER =====

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;


  hardware.intelgpu.driver = "xe";

  # ===== NETWORKING =====

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # ===== BLUETOOTH =====

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  # ===== LOCALE & TIME =====

  time.timeZone = "Europe/Istanbul";
  i18n.defaultLocale = "en_US.UTF-8";
  console.useXkbConfig = true;
  services.xserver.xkb.layout = "tr";

  # ===== NIX CONFIGURATION =====

  nixpkgs.config.allowUnfree = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 3";
    flake = "/etc/nixos/";
  };

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # ===== KERNEL & PERFORMANCE =====

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.tlp = {
    settings = {
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      PLATFORM_PROFILE_ON_AC = "performance";
    };
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  # ===== MEMORY =====

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };

  # ===== AUDIO =====

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # ===== HARDWARE =====

  services.thermald.enable = true;
  services.fprintd.enable = true;
  security.pam.services.sudo.fprintAuth = false;

  # Enable firmware updates
  services.fwupd.enable = true;

  # ===== DOCUMENTATION =====

  # Disable unused documentation (saves space & build time)
  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
    nixos.enable = false;
  };

  # ===== SYSTEM STATE VERSION =====

  # Don't change this unless you know what you're doing
  system.stateVersion = "25.11"; # Change to your NixOS version
}
