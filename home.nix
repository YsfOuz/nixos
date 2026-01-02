{
  config,
  pkgs,
  lib,
  ...
}: {
  # ============================================================================
  # HOME MANAGER CORE
  # ============================================================================
  home.username = "yusuf";
  home.homeDirectory = "/home/yusuf";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  # ============================================================================
  # PACKAGES
  # ============================================================================
  programs.obs-studio.enable = true;
  programs.spicetify.enable = true;
  programs.java.enable = true;
  programs.gcc.enable = true;

  home.packages = with pkgs; [
    # --- Development ---
    rustc
    cargo
    python3
    nodejs

    # --- Media & Design ---
    ffmpeg
    gimp
    vlc

    # --- Games & Fun ---
    prismlauncher
    mindustry

    # --- Productivity ---
    libreoffice

    # --- Utils ---
    unzip
    zip
    nvtopPackages.intel
    supercollider
  ];

  # ============================================================================
  # PROGRAMS CONFIGURATION
  # ============================================================================

  # --- Git ---
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Yusuf Oğuz";
        email = "ysfouz2007@gmail.com";
      };
    };
  };

  # --- File Management ---
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
  };

  # --- Monitoring & Info ---
  programs.btop.enable = true;

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "linux";
        padding = {
          top = 2;
          right = 4;
          left = 4;
          bottom = 2;
        };
      };
      display = {
        separator = "  ";
        color = {
          separator = "white";
        };
      };
      modules = [
        "break"
        # Hardware Section
        {
          type = "host";
          key = " PC";
          keyColor = "blue";
          format = "{1}";
        }
        {
          type = "cpu";
          key = "╭ 󰘚 CPU";
          keyColor = "green";
          showPeCoreCount = true;
          format = "{1}";
        }
        {
          type = "gpu";
          key = "├ 󰢮 GPU";
          keyColor = "yellow";
          format = "{2}";
        }
        {
          type = "memory";
          key = "├  RAM";
          keyColor = "magenta";
          format = "{1} / {2} ({3})";
        }
        {
          type = "disk";
          key = "╰  DSK";
          keyColor = "cyan";
          format = "{1} / {2} ({3})";
        }

        "break"

        # Software Section
        {
          type = "kernel";
          key = " KER";
          keyColor = "white";
          format = "{2}";
        }
        {
          type = "os";
          key = "󰌽 OS";
          keyColor = "blue";
          format = "{2}";
        }
        {
          type = "wm";
          key = " WM";
          keyColor = "yellow";
          format = "{1}";
        }
        {
          type = "shell";
          key = " SH";
          keyColor = "green";
          format = "{1}";
        }
        {
          type = "terminal";
          key = " TER";
          keyColor = "red";
          format = "{1}";
        }
        {
          type = "editor";
          key = "󰷈 EDI";
          keyColor = "magenta";
          format = "{2}";
        }

        "break"

        # Color Palette
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
      ];
    };
  };

  # ============================================================================
  # XDG USER DIRECTORIES
  # ============================================================================
  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
