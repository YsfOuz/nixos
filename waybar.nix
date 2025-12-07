{
  pkgs,
  ...
}:
{
  services.mako = {
    enable = true;
    settings = {
      border-radius = 5;
      margin = 5;
      default-timeout = 5000;
      border-size = 0;
    };
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.override { cavaSupport = true; };
    systemd.enable = true;

    settings = {
      topBar = {
        position = "top";
        layer = "top";
        height = 40;
        spacing = 5;
        margin-top = 5;
        margin-right = 5;
        margin-left = 5;

        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "tray"
          "temperature#cpu"
          "temperature#gpu"
          "pulseaudio"
          "backlight"
          "battery"
          "clock"
        ];

        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            urgent = "󰀨";
            active = "";
            default = "";
          };
          sort-by-number = true;
        };

        "clock" = {
          format = "{:%H:%M} 󰅐 ";
          format-alt = "{:%m %d %Y (%R)} 󰃭 ";
          tooltip = false;
        };

        "backlight" = {
          format = "{percent}% {icon}";
          format-icons = [
            "󰃞"
            "󰃟"
            "󰃠"
          ];
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% 󰂄";
          format-plugged = "{capacity}% 󰂄";
          format-alt = "{time} {icon}";
          format-icons = [
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
        };

        "pulseaudio" = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon}󰂯 {format_source}";
          format-bluetooth-muted = "󰝟 {icon}󰂯 {format_source}";
          format-muted = "0% 󰝟 {format_source}";
          format-source = "{volume}% 󰍬";
          format-source-muted = "󰍭";
          format-icons = {
            headphone = "󰋋";
            hands-free = "󰋎";
            headset = "󰋎";
            phone = "󰏲";
            portable = "󰏲";
            car = "󰄋";
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = "pavucontrol";
        };

        "hyprland/window".max-length = 45;
        "tray".spacing = 10;

        "temperature#cpu" = {
          hwmon-path-abs = "/sys/devices/platform/thinkpad_hwmon/hwmon";
          input-filename = "temp1_input";
          format = "CPU {temperatureC}°C ";
        };
        "temperature#gpu" = {
          hwmon-path-abs = "/sys/devices/platform/thinkpad_hwmon/hwmon";
          input-filename = "temp2_input";
          format = "GPU {temperatureC}°C ";
        };
      };
      bottomBar = {
        name = "bottomBar";
        position = "bottom";
        layer = "top";
        height = 40;
        spacing = 5;
        margin-bottom = 5;
        margin-right = 5;
        margin-left = 5;

        modules-left = [ "mpris#name" ];
        modules-center = [ "cava" ];
        modules-right = [
          "mpris#prev"
          "mpris#play-pause"
          "mpris#next"
        ];

        "cava" = {
          sensitivity = 2;
          bars = 32;
          bar_delimiter = 0;
          input_delay = 2;
          format-icons = [
            "⠀"
            "⡀"
            "⣀"
            "⣄"
            "⣤"
            "⣦"
            "⣶"
            "⣷"
            "⣿"
            /*
              "▁"
              "▂"
              "▃"
              "▄"
              "▅"
              "▆"
              "▇"
              "█"
            */
          ];
        };
        "mpris#prev" = {
          format = "";
          on-click = "playerctl previous";
          tooltip = false;
        };
        "mpris#play-pause" = {
          format = "{status_icon}";
          status-icons = {
            playing = "";
            paused = "";
            stopped = "";
          };
        };
        "mpris#next" = {
          format = "";
          on-click = "playerctl next";
          tooltip = false;
        };
        "mpris#name" = {
          format = "{artist} - {title}";
          max-length = 50;
          tooltip = false;
        };
      };
    };

    style = ''
      * {
        font-family: "NotoSans Nerd Font";
        font-weight: bold;
        font-size: 16;
        border-radius: 5;
      }
      #cava {
      font-size: 24;
      }
      .bottomBar .modules-left {
      padding-left: 200;
      }
      .bottomBar .modules-right {
      padding-right: 200;
      }
      #mpris.play-pause, #mpris.prev, #mpris.next {
      font-size: 24;
      }
    '';
  };
}
