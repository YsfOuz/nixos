{
  config,
  pkgs,
  ...
}: {
  # ============================================================================
  # SYSTEM CORE
  # ============================================================================

  # --- Bootloader ---
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
    efi.canTouchEfiVariables = true;
  };

  # --- Kernel ---
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
  };

  # ============================================================================
  # HARDWARE
  # ============================================================================

  hardware.enableRedistributableFirmware = true;

  # --- Graphics ---
  hardware.graphics = {
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
      intel-compute-runtime
      level-zero
    ];
  };

  # --- Bluetooth ---
  hardware.bluetooth = {
    enable = true;
    settings.General.Experimental = true;
  };

  # ============================================================================
  # POWER MANAGEMENT & THERMAL
  # ============================================================================
  services.throttled.enable = true;
  services.auto-cpufreq.enable = true;
  services.thermald.enable = true;

  services.thinkfan = {
    enable = true;
    smartSupport = true;
    levels = [
      [0 0 52]
      [2 48 60]
      [4 56 68]
      [5 64 76]
      [7 72 84]
      [127 80 32767]
    ];
  };

  # ============================================================================
  # SERVICES & FEATURES
  # ============================================================================

  # --- ThinkPad Specifics ---
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

  # --- Audio (PipeWire) ---
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # --- Environment Variables ---
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };
  services.gvfs.enable = true;

  # ============================================================================
  # LOCALIZATION
  # ============================================================================
  time.timeZone = "Europe/Istanbul";
  i18n.defaultLocale = "en_US.UTF-8";
  console.useXkbConfig = true;
  services.xserver.xkb.layout = "tr";

  # ============================================================================
  # NIX CONFIGURATION
  # ============================================================================
  nixpkgs.config.allowUnfree = true;

  # --- Nix Helper ---
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 3";
    flake = "/etc/nixos/";
  };

  # --- Settings & Caching ---
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes"];
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # ============================================================================
  # MISC
  # ============================================================================
  documentation = {
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
    nixos.enable = false;
  };

  system.stateVersion = "25.11";
}
