{ pkgs, ... }:
{

  # ==========================================================================
  # BOOT
  # ==========================================================================

  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
    efi.canTouchEfiVariables = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "i915.force_probe=!7d55"
    "xe.force_probe=7d55"

    "nowatchdog"
    "quiet"
  ];

  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
    "vm.swappiness" = 10;
    "vm.dirty_ratio" = 10;
    "vm.dirty_background_ratio" = 5;
  };

  # ==========================================================================
  # HARDWARE
  # ==========================================================================

  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
      intel-compute-runtime
      level-zero
    ];
  };

  hardware.bluetooth = {
    enable = true;
    settings.General.Experimental = true;
  };

  # ==========================================================================
  # POWER MANAGEMENT
  # ==========================================================================

  services.power-profiles-daemon.enable = true;

  # ==========================================================================
  # SERVICES
  # ==========================================================================

  # --- ThinkPad ---
  services.fprintd.enable = true;
  services.fwupd.enable = true;

  # --- Storage ---
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };
  services.fstrim.enable = true;

  # --- Networking ---
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
  services.blueman.enable = true;

  # --- Audio ---
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # --- Desktop ---
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # --- Environment ---
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  # ==========================================================================
  # LOCALIZATION
  # ==========================================================================

  time.timeZone = "Europe/Istanbul";
  i18n.defaultLocale = "en_US.UTF-8";
  console.useXkbConfig = true;
  services.xserver.xkb.layout = "tr";

  # ==========================================================================
  # NIX
  # ==========================================================================

  nixpkgs.config.allowUnfree = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
  };

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # ==========================================================================
  # MISC
  # ==========================================================================

  documentation = {
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
    nixos.enable = false;
  };

  system.stateVersion = "25.11";
}
