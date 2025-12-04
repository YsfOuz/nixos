{ pkgs, ... }:
{
  services.mako = {
    enable = true;
    settings = {
      border-radius = 5;
      margin = 5;
      default-timeout = 5000;
    };
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.override { cavaSupport = true; };
    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        height = 40;
        spacing = 5;
        margin-top = 5;
        margin-right = 5;
        margin-left = 5;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [
          "cava"
          "mpris"
        ];
        modules-right = [
          "tray"
          "temperature"
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

        "mpris" = {
          format = "{status_icon} {dynamic}";
          dynamic-order = [
            "album"
            "title"
            "artist"
          ];
          dynamic-separator = " => ";
          status-icons = {
            paused = " ";
            playing = " ";
          };
          ignored-players = [ "firefox" ];
        };

        "cava" = {
          sensitivity = 2;
          bar_delimiter = 0;
          bars = 12;
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
          stereo = false;
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

        "temperature" = {
          thermal-zone = 8;
          critical-threshold = 80;
          format = "CPU {temperatureC}°C ";
          format-critical = "CPU {temperatureC}°C ";
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
      window#waybar { border-width: 2; border-style: solid; }
      #battery.critical {
        color: @base08;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      #temperature.critical { color: @base08; }
      .module { margin-top: 4; margin-bottom: 4; padding-right: 2; padding-left: 2; }
      #tray { border-style: solid; border-width: 2; }
      @keyframes blink {
        to { color: @base00; background-color: @base08; }
      }
    '';
  };
}
