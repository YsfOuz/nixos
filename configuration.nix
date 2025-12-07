{ config, pkgs, ... }:

{
  # ===== BOOTLOADER =====
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  
  # Silent & fast boot
  boot.consoleLogLevel = 3;
  boot.kernelParams = [ "quiet" "splash" ];
  
  # ===== NETWORKING =====
  
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" "1.0.0.1" ];  # Cloudflare DNS
    
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };
  
  # Faster boot - don't wait for network
  systemd.services.NetworkManager-wait-online.enable = false;
  
  # Network Manager Applet
  programs.nm-applet.enable = true;

  # ===== BLUETOOTH =====
  
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;  # Save battery
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;  # Better codec support
      };
    };
  };
  
  services.blueman.enable = true;

  # ===== LOCALE & TIME =====
  
  time.timeZone = "Europe/Istanbul";  # Change to your timezone
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
    # Optimization
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
    
    # Build performance (32GB RAM = build everything fast!)
    max-jobs = "auto";
    cores = 0;
    
    # Use binary caches (don't compile everything)
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    
    # Additional performance tweaks
    warn-dirty = false;  # Don't warn about dirty git trees
    connect-timeout = 5;  # Faster timeout on unreachable substituters
  };

  # ===== POWER MANAGEMENT =====
  
  services.upower.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      # CPU Performance
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 30;
      
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      
      # Battery Care (extends battery lifespan)
      START_CHARGE_THRESH_BAT0 = 80;
      STOP_CHARGE_THRESH_BAT0 = 90;
      
      # Platform Profile
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";
      
      # Disk
      DISK_APM_LEVEL_ON_AC = "254 254";
      DISK_APM_LEVEL_ON_BAT = "128 128";
      
      # Network
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";
      
      # Bluetooth (auto-disable on battery)
      DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";
      DEVICES_TO_ENABLE_ON_AC = "bluetooth wifi";
      DEVICES_TO_DISABLE_ON_BAT = "bluetooth";
      
      # USB Autosuspend (saves power)
      USB_AUTOSUSPEND = 1;
      USB_EXCLUDE_AUDIO = 1;  # Don't suspend audio devices
      USB_EXCLUDE_BTUSB = 0;  # Allow Bluetooth suspend
      USB_EXCLUDE_PHONE = 0;
      USB_EXCLUDE_PRINTER = 1;  # Don't suspend printers
      USB_EXCLUDE_WWAN = 0;
    };
  };

  # ===== KERNEL & PERFORMANCE =====
  
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # System tuning (optimized for 32GB RAM + NVMe)
  boot.kernel.sysctl = {
    # Memory management
    "vm.swappiness" = 1;
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_ratio" = 20;
    "vm.dirty_background_ratio" = 10;
    "vm.min_free_kbytes" = 131072;
    
    # Network performance
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.netdev_max_backlog" = 16384;
    "net.core.rmem_max" = 134217728;
    "net.core.wmem_max" = 134217728;
    "net.ipv4.tcp_rmem" = "4096 87380 67108864";
    "net.ipv4.tcp_wmem" = "4096 65536 67108864";
    
    # File system
    "fs.inotify.max_user_watches" = 524288;
    "fs.file-max" = 2097152;
  };

  # ===== MEMORY =====
  
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;  # 8GB zram with 32GB RAM
  };

  # ===== GAMING =====
  
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;  # Higher priority for games
      };
      # GPU optimizations
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        amd_performance_level = "high";
      };
    };
  };
  
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  # ===== AUDIO =====
  
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    
    # Low latency audio
    extraConfig.pipewire."92-low-latency" = {
      context.properties = {
        default.clock.rate = 48000;
        default.clock.quantum = 1024;
        default.clock.min-quantum = 512;
        default.clock.max-quantum = 2048;
      };
    };
  };

  # ===== HARDWARE =====

  services.fprintd.enable = true;
  security.pam.services.sudo.fprintAuth = false;  

  # Enable firmware updates
  services.fwupd.enable = true;

  # ===== SYSTEM PACKAGES =====

  environment.systemPackages = with pkgs; [
    # System monitoring
    btop          # System monitor
    nvtopPackages.intel         # GPU monitor
    
    # Gaming
    mangohud      # FPS overlay
    
    # Network
    wget
    curl
    
    # Hardware info
    pciutils      # lspci
    usbutils      # lsusb
    
    # Useful utilities
    tree          # Directory tree view
    htop          # Alternative system monitor
    inxi          # System info tool
  ];

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
  system.stateVersion = "25.11";  # Change to your NixOS version
}
