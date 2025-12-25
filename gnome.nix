{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # Core GNOME Apps
    gnome-terminal
    nautilus
    gnome-text-editor
    gnome-system-monitor

    # Extensions
    gnomeExtensions.appindicator
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.vitals
    gnomeExtensions.dash-to-dock
    gnomeExtensions.arcmenu
  ];

  dconf = {
    enable = true;
    settings = with lib.hm.gvariant; {

      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          appindicator.extensionUuid
          clipboard-indicator.extensionUuid
          vitals.extensionUuid
          dash-to-dock.extensionUuid
          arcmenu.extensionUuid
        ];
        favorite-apps = [
          "firefox.desktop"
          "spotify.desktop"
          "org.gnome.Nautilus.desktop"
          "org.gnome.Terminal.desktop"
        ];
      };

      "org/gnome/shell/keybindings" = {
        switch-to-application-1 = [ ];
        switch-to-application-2 = [ ];
        switch-to-application-3 = [ ];
        switch-to-application-4 = [ ];
      };

      # ArcMenu - Spotlight-like launcher
      "org/gnome/shell/extensions/arcmenu" = {
        arcmenu-hotkey = [ "<Super>space" ];
        menu-button-appearance = "None";
        menu-layout = "Runner";
        show-activities-button = true;
      };

      # Dash to Dock - macOS-like dock
      "org/gnome/shell/extensions/dash-to-dock" = {
        dock-position = "LEFT";
        show-show-apps-button = false;
        hot-keys = false;
      };

      "org/gnome/shell/extensions/clipboard-indicator" = {
        enable-keybindings = false;
      };

      # Vitals - Show only temperature
      "org/gnome/shell/extensions/vitals" = {
        hot-sensors = [ "_temperature_acpi_thermal zone_" ];
        show-voltage = false;
        show-fan = false;
        show-memory = false;
        show-processor = false;
        show-system = false;
        show-network = false;
        show-storage = false;
        show-battery = false;
        show-gpu = false;
      };

      # Desktop Interface
      "org/gnome/desktop/interface" = {
        show-battery-percentage = true;
        enable-hot-corners = false;
      };

      # Window Manager
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
        resize-with-right-button = true;
        num-workspaces = 4;
        focus-mode = "sloppy";
        auto-raise = true;
      };

      # Window Manager Keybindings
      "org/gnome/desktop/wm/keybindings" = {
        switch-input-source = [ ];
        close = [ "<Super>q" ];
        toggle-fullscreen = [ "<Super>f" ];
        toggle-maximized = [ "<Super>t" ];
        switch-windows = [ "<Alt>Tab" ];
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        move-to-workspace-1 = [ "<Super><Shift>1" ];
        move-to-workspace-2 = [ "<Super><Shift>2" ];
        move-to-workspace-3 = [ "<Super><Shift>3" ];
        move-to-workspace-4 = [ "<Super><Shift>4" ];
      };

      # Custom Keybindings
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "Terminal";
        command = "gnome-terminal";
        binding = "<Super>Return";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        name = "File Manager";
        command = "nautilus";
        binding = "<Super>e";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
        name = "Browser";
        command = "firefox";
        binding = "<Super>b";
      };

      # Mutter - Window Manager Backend
      "org/gnome/mutter" = {
        dynamic-workspaces = false;
        edge-tiling = true;
        experimental-features = [
          "scale-monitor-framebuffer"
          "variable-refresh-rate"
        ];
      };

      # Privacy
      "org/gnome/desktop/privacy" = {
        remember-recent-files = false;
        remove-old-temp-files = true;
        remove-old-trash-files = true;
      };

      "org/gnome/desktop/search-providers" = {
        disabled = true;
      };

      # Peripherals
      "org/gnome/desktop/peripherals/touchpad" = {
        send-events = "disabled-on-external-mouse";
      };

      # System
      "org/gnome/desktop/sound" = {
        event-sounds = false;
      };

      # Text Editor
      "org/gnome/TextEditor" = {
        highlight-current-line = true;
        restore-session = false;
        show-line-numbers = true;
      };

      # Nautilus
      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "list-view";
      };

      "org/gnome/nautilus/list-view" = {
        default-zoom-level = "large";
      };
    };
  };

  stylix.targets.qt.platform = "qtct";
}
