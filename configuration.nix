{ pkgs, ... }:
{

  # ==========================================================================
  # BOOT
  # ==========================================================================

  boot.loader = {
    efi.canTouchEfiVariables = true;
    limine = {
      enable = true;
      maxGenerations = 10;
    };

  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "i915.force_probe=!7d55"
    "xe.force_probe=7d55"

    "nowatchdog"
    "quiet"
  ];

  boot.kernel.sysctl = {
    # Network
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };

  # ==========================================================================
  # HARDWARE
  # ==========================================================================

  hardware.enableAllFirmware = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
      intel-compute-runtime
      level-zero
      intel-npu-driver
    ];
  };

  hardware.bluetooth = {
    enable = true;
    settings.General.Experimental = true;
  };

  # ==========================================================================
  # POWER MANAGEMENT
  # ==========================================================================

  services.thermald.enable = true;
  services.tlp = {
    enable = true;
    pd.enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  /*
    services.scx = {
      enable = true;
      scheduler = "scx_lavd";
    };
  */

  # ==========================================================================
  # SERVICES
  # ==========================================================================

  # --- ThinkPad ---
  services.hardware.bolt.enable = true;
  services.upower.enable = true;
  services.fprintd.enable = true;
  services.fwupd.enable = true;
  services.irqbalance.enable = true;

  # --- Storage ---
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };
  services.fstrim.enable = true;
  boot.tmp.useTmpfs = true;

  # --- Networking ---
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
    };
    firewall = {
      allowedTCPPorts = [
        25565
        1716
        8080
      ];
      allowedUDPPorts = [
        19132
        1714
        1715
      ];
    };
  };
  services.blueman.enable = true;

  # --- Audio ---
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # --- Desktop ---
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.dbus.implementation = "broker";

  # --- Environment ---
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    NIXOS_OZONE_WL = "1";
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
    flake = "/etc/nixos";
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

  nix.daemonCPUSchedPolicy = "idle";
  nix.daemonIOSchedClass = "idle";

  # ==========================================================================
  # MISC
  # ==========================================================================

  documentation = {
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
    nixos.enable = false;
  };

  system.stateVersion = "26.05";
}
