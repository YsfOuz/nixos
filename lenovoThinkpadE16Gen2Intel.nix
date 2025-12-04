{
  config,
  lib,
  pkgs,
  ...
}:

{
  # =========================================================================
  # LENOVO THINKPAD E16 GEN 2 (METEOR LAKE)
  # =========================================================================

  # --- 1. Boot & Kernel Optimizations ---
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-intel" ];

    kernelParams = [
      "i915.force_probe=!7d55"
      "xe.force_probe=7d55"
      "snd_hda_intel.power_save=1"
      "nmi_watchdog=0"
    ];

    extraModprobeConfig = ''
      options thinkpad_acpi fan_control=1
      options iwlwifi power_save=1
      options iwlmvm power_scheme=3
      options btusb enable_autosuspend=1
      options snd_hda_intel power_save=1
    '';

    kernel.sysctl = {
      "net.core.default_qdisc" = "fq";
      "net.ipv4.tcp_congestion_control" = "bbr";
      "vm.swappiness" = 30;
      "vm.vfs_cache_pressure" = 50;
      "net.ipv4.conf.default.rp_filter" = 1;
      "net.ipv4.conf.all.rp_filter" = 1;
    };
  };

  # --- 2. Hardware Support (Graphics & Firmware) ---
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      vpl-gpu-rt
      libvdpau-va-gl
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    MOZ_ENABLE_WAYLAND = "1";
    VDPAU_DRIVER = "va_gl";
  };

  services.fwupd.enable = true;
  services.fstrim.enable = true;
  zramSwap.enable = true;

  hardware.cpu.intel.updateMicrocode = true;
  services.fprintd.enable = true;
  security.pam.services.sudo.fprintAuth = false;

  # --- 3. Audio & Connectivity ---
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Experimental = true;
  };

  networking.networkmanager = {
    enable = true;
    wifi.powersave = true;
  };

  # --- 4. Power Management (Balanced Profile) ---
  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;
  services.thinkfan = {
    enable = true;
    sensors = [
      {
        type = "tpacpi";
        query = "/proc/acpi/ibm/thermal";
      }
    ];

    levels = [
      [
        0
        0
        45
      ] # Fan OFF below 45°C
      [
        1
        40
        50
      ] # Low speed
      [
        2
        48
        55
      ]
      [
        3
        53
        60
      ] # Medium speed starts earlier (common heat soak point)
      [
        4
        58
        65
      ]
      [
        6
        63
        70
      ] # High speed
      [
        7
        68
        75
      ] # Maximum normal speed
      [
        "level auto"
        73
        32767
      ] # Emergency fallback to BIOS auto control above 82°C
    ];
  };

  services.tlp = {
    enable = true;
    settings = {
      # CPU Policy: Performance on AC, Power on BAT
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

      # Platform Profile
      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # CPU Boost
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      # Storage & Safety
      MAX_LOST_WORK_SECS_ON_AC = 15;
      MAX_LOST_WORK_SECS_ON_BAT = 60;

      # Battery Care (80% Limit)
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;

      # WiFi Power
      WIFI_PWR_ON_AC = "on";
      WIFI_PWR_ON_BAT = "on";
    };
  };

  # --- 5. Monitoring Tools ---
  environment.systemPackages = with pkgs; [
    sof-firmware
    alsa-ucm-conf
    playerctl
    nvtopPackages.intel
    pavucontrol
  ];
}
