{ pkgs, inputs, ... }:
{
  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      isDefault = true;

      search = {
        force = true;
        default = "ddg";
      };

      extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        ublock-origin
      ];

      settings = {
        # --- Performance ---
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        "widget.dmabuf.force-enabled" = true;

        # --- Privacy & Security ---
        "browser.contentblocking.category" = "strict";
        "dom.security.https_only_mode" = true;
        "network.predictor.enabled" = false;
        "network.prefetch-next" = false;
        "security.tls.enable_0rtt_data" = false;

        # --- UI ---
        "browser.uidensity" = 1;
        "browser.toolbars.bookmarks.visibility" = "never";
      };
    };

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableFormHistory = true;
      DisableFirefoxScreenshots = true;
      DisableSetDesktopBackground = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
    };
  };

  stylix.targets.firefox.profileNames = [ "default" ];
}
