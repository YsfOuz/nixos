{
  pkgs,
  lib,
  config,
  ...
}: {
  # ============================================================================
  # PACKAGES
  # ============================================================================
  home.packages = with pkgs; [
    pavucontrol
    wl-clipboard
    thunar
    tumbler
    rofi-power-menu
    brightnessctl
  ];

  # ============================================================================
  # PROGRAMS & UTILITIES
  # ============================================================================

  # --- Rofi (Launcher) ---
  programs.rofi = {
    enable = true;
    extraConfig.show-icons = true;
    location = "left";
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*".border-radius = mkLiteral "8px";
      "window" = {
        height = mkLiteral "100%";
        width = mkLiteral "25%";
      };
      "mainbox" = {
        background-color = mkLiteral "transparent";
        children = map mkLiteral ["inputbar" "listview"];
      };
      "inputbar" = {
        spacing = mkLiteral "8px";
        padding = mkLiteral "8px";
        children = map mkLiteral ["entry"];
      };
      "entry".placeholder = "Search...";
      "listview" = {
        spacing = mkLiteral "4px";
        padding = mkLiteral "8px";
        background-color = mkLiteral "transparent";
      };
      "element" = {
        spacing = mkLiteral "8px";
        padding = mkLiteral "4px";
        background-color = mkLiteral "transparent";
      };
      "element-text" = {
        background-color = lib.mkForce (mkLiteral "transparent");
        vertical-align = mkLiteral "0.5";
      };
      "element-icon" = {
        background-color = lib.mkForce (mkLiteral "transparent");
        size = mkLiteral "32px";
      };
    };
  };

  # --- Kitty (Terminal) ---
  programs.kitty = {
    enable = true;
    settings = {
      window_padding_width = 4;
      remember_window_size = "no";
      initial_window_width = "960";
      initial_window_height = "600";
    };
  };

  # --- Waybar (Status Bar) ---
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        margin-top = 8;
        margin-left = 8;
        margin-right = 8;

        modules-left = ["hyprland/workspaces" "hyprland/window"];
        modules-center = ["clock"];
        modules-right = [
          "tray"
          "idle_inhibitor"
          "pulseaudio"
          "backlight"
          "temperature"
          "battery"
        ];

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰈈";
            deactivated = "󰈉";
          };
        };
        "hyprland/workspaces" = {
          format = "{icon}";
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
          };
        };
        "hyprland/window".max-length = 48;
        "clock" = {
          format = "󰥔 {:%H:%M}";
          format-alt = "󰃭 {:%a, %b %d}";
          tooltip-format = "<tt>{calendar}</tt>";
        };
        "temperature" = {
          thermal-zone = 8;
          format = "{icon} {temperatureC}°C";
          format-icons = ["󱃃" "󰔏" "󱃂" "󰸁" "󰸃"];
        };
        "battery" = {
          format = "{icon} {capacity}%";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰚥 {capacity}%";
          format-full = "󰁹 {capacity}%";
        };
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰝟";
          format-icons = {
            default = ["󰕿" "󰖀" "󰕾"];
            headphone = "󰋋";
            headset = "󰋎";
            hands-free = "󰋎";
          };
          on-click = "pavucontrol";
        };
        "backlight" = {
          format = "{icon} {percent}%";
          format-icons = ["󰃞" "󰃟" "󰃠"];
        };
        "tray" = {
          icon-size = 16;
          spacing = 8;
        };
      }
    ];
    style = ''
      * {
        border-radius: 8px;
      }
      .module {
        padding-right: 8;
        padding-left: 8;
      }
    '';
  };

  # ============================================================================
  # SERVICES & DAEMONS
  # ============================================================================

  # --- Dunst (Notifications) ---
  services.dunst = {
    enable = true;
    settings = {
      global = {
        dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p 'Action'";
        mouse_left_click = "close_current";
        mouse_right_click = "context";
        frame_width = 0;
        padding = 8;
        corner_radius = 8;
      };
      urgency_low.timeout = 3;
      urgency_normal.timeout = 5;
      urgency_critical.timeout = 0;
    };
  };

  # --- System Services ---
  services.cliphist = {
    enable = true;
    extraOptions = ["-max-items" "50"];
  };

  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;
  services.playerctld.enable = true;
  services.hyprpaper.enable = true;

  services.hyprsunset = {
    enable = true;
    settings = {
      profile = [
        {
          time = "8:00";
          identity = true;
        }
        {
          time = "20:00";
          temperature = 5000;
          gamma = 0.8;
        }
      ];
    };
  };

  # --- Locking & Idle ---
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 600;
          on-timeout = "hyprlock";
        }
        {
          timeout = 900;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };
      background = lib.mkForce [
        {
          path = "screenshot";
          blur_passes = 4;
          blur_size = 4;
          noise = 0.05;
        }
      ];
    };
  };

  programs.hyprshot = {
    enable = true;
    saveLocation = "$HOME/Pictures/Screenshots";
  };

  # ============================================================================
  # HYPRLAND WINDOW MANAGER
  # ============================================================================
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      # --- Variables ---
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$menu" = "rofi -show drun";

      monitor = ",preferred,auto,1";

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };

      # --- Appearance ---
      general = {
        gaps_in = 8;
        gaps_out = 8;
        border_size = 0;
      };

      decoration = {
        dim_inactive = true;
        dim_strength = 0.25;
        rounding = 8;
        shadow = {
          range = 16;
          render_power = 16;
        };
        blur = {
          size = 4;
          passes = 4;
          noise = 0.05;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "bouncy, 0.25, -0.25, 0.75, 1.25"
        ];
        animation = [
          "fade, 1, 2, bouncy"
          "windows, 1, 2, bouncy, popin"
          "layers, 1, 2, bouncy, slide"
          "workspaces, 1, 2, bouncy, slide"
        ];
      };

      # --- Input ---
      input = {
        kb_layout = "tr";
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
        };
      };

      misc = {
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
        vfr = true;
      };

      # --- Rules ---
      windowrule = [
        "match:class kitty, float on, size 960 600, center on"
      ];
      layerrule = [
        "match:namespace waybar, blur on"
        "match:namespace waybar, blur_popups on"
        "match:namespace waybar, ignore_alpha 0"

        "match:namespace notifications, blur on"
        "match:namespace notifications, blur_popups on"
        "match:namespace notifications, ignore_alpha 0"

        "match:namespace rofi, blur on"
        "match:namespace rofi, blur_popups on"
        "match:namespace rofi, ignore_alpha 0"
      ];

      # --- Keybindings ---
      bind = [
        # Application Launchers
        "$mod, Return, exec, $terminal"
        "$mod, Space, exec, $menu"
        "$mod, B, exec, firefox"
        "$mod, E, exec, thunar"
        "$mod, N, exec, dunstctl history-pop"

        # Window Management
        "$mod, Q, killactive"
        "$mod, T, togglefloating"
        "$mod, F, fullscreen"
        "ALT, Tab, cyclenext"
        "ALT, Tab, bringactivetotop"

        # Actions
        "$mod, C, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$mod, L, exec, hyprlock"
        "$mod, Escape, exec, rofi -show menu -modi 'menu:rofi-power-menu'"
        ", Print, exec, hyprshot -m region"

        # Workspace Switching
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move Window to Workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
      ];

      # --- Media Controls ---
      bindl = [
        # Volume
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

        # Brightness
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      # --- Mouse Bindings ---
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
