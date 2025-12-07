{
  pkgs,
  config,
  lib,
  ...
}:
let
  audioSource = "$(pactl get-default-sink).monitor";
in
{
  # --- Services (Wallpaper, Lock, Idle, Sunset) ---
  services.hyprpaper.enable = true;
  services.hyprpolkitagent.enable = true;

  services.hyprsunset = {
    enable = true;
    settings = {
      max-gamma = 150;
      profile = [
        {
          time = "08:00";
          identity = true;
        }
        {
          time = "20:00";
          temperature = 5500;
          gamma = 0.8;
        }
      ];
    };
  };

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
          timeout = 150;
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
          on-resume = "brightnessctl -rd rgb:kbd_backlight";
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
      background.blur_passes = 3;
      input-field = {
        position = "0, 100";
        halign = "center";
        valign = "bottom";
      };
      label = [
        {
          text = "$TIME";
          font_size = 150;
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:60000] date +'%A, %d %B'";
          position = "0, -150";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  # --- Main Configuration ---
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };

      # Variables
      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";
      "$fileManager" = "thunar";
      "$menu" = "rofi -show drun";

      # Monitor & General
      monitor = ",preferred,auto,1";

      general = {
        allow_tearing = true;
        gaps_in = 5;
        gaps_out = 5;
        border_size = 0;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      input.kb_layout = "tr";

      decoration = {
        shadow.enabled = lib.mkForce false;
        rounding = 5;
        blur = {
          passes = 3;
          size = 3;
        };
      };

      bezier = [ "bouncy, 0.2, -0.2, 0.2, 1.2" ];

      animation = [
        "windows, 1, 2, bouncy, popin"
        "workspaces, 1, 2, bouncy, slide"
        "fade, 1, 2, bouncy"
        "layers, 1, 2, bouncy, slide"
      ];

      # Rules
      windowrulev2 = [ "float, class:^(Alacritty)$" ];

      layerrule = [
        "blur, notifications"
        "ignorezero, notifications"
        "blur, waybar"
        "ignorezero, waybar"
        "blur, rofi"
        "ignorezero 0.1, rofi"
      ];

      # Inputs
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      bind = [
        # Launchers
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, SPACE, exec, $menu"

        # Window Ops
        "$mainMod, Q, killactive,"
        "$mainMod, T, togglefloating,"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, F, fullscreen,"

        # System
        "$mainMod, L, exec, hyprlock"
        "SUPER, C, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "ALT, Tab, cyclenext,"

        # Screenshots & Recording
        ",PRINT, exec, hyprshot -m window"
        "$mainMod, PRINT, exec, hyprshot -m region"
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mainMod, ${toString ws}, workspace, ${toString ws}"
            "$mainMod SHIFT, ${toString ws}, movetoworkspace, ${toString ws}"
          ]
        ) 9
      ))
      ++ [
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
      ];
    };
  };
}
