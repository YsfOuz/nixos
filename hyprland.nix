{
  pkgs,
  lib,
  config,
  ...
}:
{

  # ==========================================================================
  # PACKAGES
  # ==========================================================================

  home.packages = with pkgs; [
    pavucontrol
    wl-clipboard
    thunar
    tumbler
    rofi-power-menu
    brightnessctl
    libnotify
  ];

  # ==========================================================================
  # PROGRAMS
  # ==========================================================================

  # --- Rofi ---
  programs.rofi = {
    enable = true;
    extraConfig.show-icons = true;
    location = "right";
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "*".border-radius = mkLiteral "8px";
        "window" = {
          height = mkLiteral "100%";
          width = mkLiteral "25%";
          margin = mkLiteral "8px";
        };
        "mainbox" = {
          background-color = mkLiteral "transparent";
          children = map mkLiteral [
            "inputbar"
            "listview"
          ];
        };
        "inputbar" = {
          spacing = mkLiteral "8px";
          padding = mkLiteral "8px";
          children = map mkLiteral [ "entry" ];
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

  # --- Kitty ---
  programs.kitty = {
    enable = true;
    settings = {
      window_padding_width = 4;
      remember_window_size = "no";
      initial_window_width = "960";
      initial_window_height = "600";
    };
  };

  # --- Waybar ---
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = [
      # Sidebar (left)
      {
        layer = "top";
        position = "left";
        width = 48;
        margin-top = 8;
        margin-left = 8;
        margin-bottom = 8;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "tray"
          "idle_inhibitor"
          "pulseaudio"
          "backlight"
          "power-profiles-daemon"
          "battery"
        ];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "";
            default = "";
            urgent = "";
          };
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
          };
        };

        "clock" = {
          format = "{:%H\n%M}";
        };

        "power-profiles-daemon" = {
          format = "{icon}";
          tooltip-format = "{profile}";
          format-icons = {
            performance = "󰓅";
            balanced = "󰾅";
            power-saver = "󰾆";
          };
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          format-charging = "󰂄";
          format-plugged = "󰚥";
          format-full = "󰁹";
          tooltip-format = "{capacity}%\n{timeTo}";
        };

        pulseaudio = {
          format = "{icon}";
          format-muted = "󰝟";
          format-icons = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
            headphone = "󰋋";
            headset = "󰋎";
            hands-free = "󰋎";
          };
          tooltip-format = "{volume}%";
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰈈";
            deactivated = "󰈉";
          };
        };

        backlight = {
          format = "{icon}";
          format-icons = [
            "󰃞"
            "󰃝"
            "󰃠"
          ];
          tooltip-format = "{percent}%";
        };

        tray = {
          icon-size = 16;
          spacing = 8;
        };
      }

      # Media bar (bottom)
      {
        layer = "top";
        position = "bottom";
        height = 48;
        margin-bottom = 8;
        margin-left = 8;
        margin-right = 8;

        modules-left = [ "mpris" ];
        modules-center = [ "cava" ];
        modules-right = [ ];

        "cava" = {
          bars = 64;
          bar_delimiter = 0;
          format-icons = [
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
        };

        mpris = {
          format = "{player_icon} {status_icon} <b>{title}</b> - {artist}";
          status-icons = {
            playing = "▶";
            paused = "⏸";
            stopped = "⏹";
          };
          max-length = 50;
          on-click = "playerctl play-pause";
          on-scroll-up = "playerctl previous";
          on-scroll-down = "playerctl next";
          ignored-players = [ "firefox" ];
        };
      }
    ];

    style = "
      * { border-radius: 8px; }
      .module { margin: 2px; padding: 2px; }
      #clock  { font-size: 24px; }
      #cava   { font-size: 24px; }
      #mpris  { font-size: 16px; }
    ";
  };

  # ==========================================================================
  # SERVICES
  # ==========================================================================

  services.cliphist = {
    enable = true;
    extraOptions = [
      "-max-items"
      "50"
    ];
  };

  services.mako = {
    enable = true;
    settings = {
      anchor = "top-left";
      margin = 8;
      padding = 8;
      border-size = 0;
      border-radius = 8;
      default-timeout = 5000;
    };
  };

  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;
  services.playerctld.enable = true;

  # ==========================================================================
  # IDLE & LOCK
  # ==========================================================================

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
          timeout = 150;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
        }
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general.hide_cursor = true;

      background = lib.mkForce [
        {
          path = "screenshot";
          blur_passes = 4;
          blur_size = 4;
          noise = 0.1;
        }
      ];

      input-field = lib.mkForce [
        {
          halign = "center";
          valign = "bottom";
          position = "0, 100";
          inner_color = "rgba(0, 0, 0, 0)";
          outer_color = "rgba(0, 0, 0, 0)";
          font_color = "rgb(255, 255, 255)";
        }
      ];

      label = [
        {
          text = "$TIME";
          font_size = 128;
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:60000] date +'%d %B %Y'";
          font_size = 16;
          position = "0, -100";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  programs.hyprshot.enable = true;

  # ==========================================================================
  # HYPRLAND
  # ==========================================================================

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;

    settings = {
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$menu" = "rofi -show drun";

      monitor = ",preferred,auto,1";

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
          noise = 0.1;
          special = true;
          popups = true;
        };
      };

      animations = {
        enabled = true;
        bezier = [ "bouncy, 0.25, -0.25, 0.75, 1.25" ];
        animation = [
          "fade,       1, 2, bouncy"
          "windows,    1, 2, bouncy, popin"
          "layers,     1, 2, bouncy, slide"
          "workspaces, 1, 2, bouncy, slide"
        ];
      };

      input = {
        kb_layout = "tr";
        accel_profile = "flat";
        touchpad = {
          natural_scroll = true;
        };
      };

      misc = {
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
        vfr = true;
      };

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };

      windowrule = [
        "match:class kitty, float on, size 960 600, center on"
      ];

      layerrule = [
        "match:namespace waybar,        blur on"
        "match:namespace waybar,        blur_popups on"
        "match:namespace waybar,        ignore_alpha 0.5"
        "match:namespace notifications, blur on"
        "match:namespace notifications, blur_popups on"
        "match:namespace notifications, ignore_alpha 0.5"
        "match:namespace rofi,          blur on"
        "match:namespace rofi,          blur_popups on"
        "match:namespace rofi,          ignore_alpha 0.5"
      ];

      bind = [
        # Launchers
        "$mod, Return, exec, $terminal"
        "$mod, Space,  exec, $menu"
        "$mod, B,      exec, firefox"
        "$mod, E,      exec, thunar"

        # Window Management
        "$mod, Q, killactive"
        "$mod, T, togglefloating"
        "$mod, F, fullscreen"
        "ALT,  Tab, cyclenext"
        "ALT,  Tab, bringactivetotop"

        # Actions
        "$mod, C,      exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$mod, L,      exec, hyprlock"
        "$mod, Escape, exec, rofi -show menu -modi 'menu:rofi-power-menu'"
        ",     Print,  exec, hyprshot -m region"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod, 2, workspace, 2"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod, 3, workspace, 3"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod, 4, workspace, 4"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod, 5, workspace, 5"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod, 6, workspace, 6"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod, 7, workspace, 7"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod, 8, workspace, 8"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod, 9, workspace, 9"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod, 0, workspace, 10"
        "$mod SHIFT, 0, movetoworkspace, 10"
      ];

      bindel = [
        ", XF86AudioRaiseVolume,  exec, wpctl set-volume --limit 1.0 @DEFAULT_AUDIO_SINK@ 5%+ && notify-send -h string:x-canonical-private-synchronous:vol -h int:value:$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf \"%d\", $2*100}') -t 1500 '󰕾' \"$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf \"%d%%\", $2*100}')\""
        ", XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && notify-send -h string:x-canonical-private-synchronous:vol -h int:value:$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf \"%d\", $2*100}') -t 1500 '󰕿' \"$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf \"%d%%\", $2*100}')\""
        ", XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notify-send -h string:x-canonical-private-synchronous:vol -t 1500 '󰝟' Muted"
        ", XF86AudioMicMute,      exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && notify-send -h string:x-canonical-private-synchronous:mic -t 1500 '󰍭' Muted"
        ", XF86MonBrightnessUp,   exec, brightnessctl set 5%+ && notify-send -h string:x-canonical-private-synchronous:bri -h int:value:$(brightnessctl -m | awk -F, '{print $4}' | tr -d '%') -t 1500 '󰃠' \"$(brightnessctl -m | awk -F, '{print $4}')\""
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%- && notify-send -h string:x-canonical-private-synchronous:bri -h int:value:$(brightnessctl -m | awk -F, '{print $4}' | tr -d '%') -t 1500 '󰃞' \"$(brightnessctl -m | awk -F, '{print $4}')\""
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
