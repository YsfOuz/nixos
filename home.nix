{ pkgs, ... }:
{

  # ==========================================================================
  # HOME MANAGER CORE
  # ==========================================================================

  home.username = "yusuf";
  home.homeDirectory = "/home/yusuf";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  # ==========================================================================
  # EDITORS
  # ==========================================================================

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings.editor.auto-format = true;
    extraPackages = with pkgs; [
      jdt-language-server
      clang-tools
      nixd
      nixfmt
      rust-analyzer
    ];
  };

  programs.zed-editor = {
    enable = true;
    extensions = [
      "java"
      "xml"
    ];
    userSettings = {
      disable_ai = true;
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
    };
    userKeymaps = [
      {
        context = "Workspace";
        bindings = {
          "ctrl-t" = "terminal_panel::Toggle";
          "ctrl-e" = "workspace::ToggleLeftDock";
        };
      }
    ];
    extraPackages = with pkgs; [
      jdt-language-server
      clang-tools
      nixd
      rust-analyzer
    ];
  };

  # ==========================================================================
  # PROGRAMS
  # ==========================================================================

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = 4;
          y = 4;
        };
      };
    };
  };

  programs.java.enable = true;
  programs.gcc.enable = true;
  programs.cargo.enable = true;

  programs.git = {
    enable = true;
    settings.user = {
      name = "Yusuf Oğuz";
      email = "ysfouz2007@gmail.com";
    };
  };

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
        {
          type = "host";
          key = " PC";
          keyColor = "blue";
          format = "{1}";
        }
        {
          type = "cpu";
          key = "󰘚 CPU";
          keyColor = "green";
          showPeCoreCount = true;
          format = "{1}";
        }
        {
          type = "gpu";
          key = "󰢮 GPU";
          keyColor = "yellow";
          format = "{2}";
        }
        {
          type = "memory";
          key = " RAM";
          keyColor = "magenta";
          format = "{1} / {2} ({3})";
        }
        {
          type = "disk";
          key = " DSK";
          keyColor = "cyan";
          format = "{1} / {2} ({3})";
        }

        "break"
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
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
      ];
    };
  };

  # ==========================================================================
  # PACKAGES
  # ==========================================================================

  home.packages = with pkgs; [
    # --- Development ---
    claude-code-bin
    lynx
    graphviz
    maven
    gnumake
    cmake

    # --- Media ---
    spotify
    gimp
    ffmpeg
    vlc

    # --- Games ---
    prismlauncher
    mindustry

    # --- Productivity ---
    libreoffice

    # --- Utils ---
    unzip
    zip
    nvtopPackages.intel
  ];

  # ==========================================================================
  # XDG
  # ==========================================================================

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
