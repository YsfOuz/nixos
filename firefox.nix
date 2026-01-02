{
  config,
  pkgs,
  ...
}: {
  stylix.targets.firefox.profileNames = ["default"];

  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      # ========================================================================
      # EXTENSIONS
      # ========================================================================
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
      ];

      # ========================================================================
      # SEARCH ENGINES
      # ========================================================================
      search = {
        default = "ddg";
        force = true;

        engines = {
          "ddg" = {
            urls = [{template = "https://duckduckgo.com/?q={searchTerms}";}];
            icon = "https://duckduckgo.com/favicon.ico";
            definedAliases = ["@ddg"];
          };

          # Disabled Engines
          "google".metaData.hidden = true;
          "bing".metaData.hidden = true;
          "amazondotcom-us".metaData.hidden = true;
          "ebay".metaData.hidden = true;
        };
      };

      # ========================================================================
      # SETTINGS
      # ========================================================================
      settings = {
        # --- Privacy & Tracking Protection ---
        "browser.contentblocking.category" = "strict";
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.donottrackheader.enabled" = true;
        "privacy.globalprivacycontrol.enabled" = true;

        # --- Security & Safebrowsing ---
        "browser.safebrowsing.malware.enabled" = true;
        "browser.safebrowsing.phishing.enabled" = true;
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_ever_enabled" = true;

        # --- DNS over HTTPS ---
        "network.trr.mode" = 2;
        "network.trr.uri" = "https://mozilla.cloudflare-dns.com/dns-query";

        # --- Telemetry (Disabled) ---
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.archive.enabled" = false;

        # --- Feature Flags ---
        "extensions.pocket.enabled" = false;
        "browser.ml.chat.enabled" = false;
        "services.sync.engine.tabs" = false;

        # --- Performance & Graphics ---
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;

        # --- Sidebar & Tabs ---
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "sidebar.main.tools" = "";
        "sidebar.verticalTabs.floating" = true;

        # --- UI Customization ---
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.uiCustomization.state" = builtins.toJSON {
          placements = {
            widget-overflow-fixed-list = [];
            nav-bar = [
              "back-button"
              "forward-button"
              "stop-reload-button"
              "urlbar-container"
              "downloads-button"
              "unified-extensions-button"
            ];
            toolbar-menubar = ["menubar-items"];
            TabsToolbar = [];
            PersonalToolbar = [];
          };
        };

        # --- Session & Downloads ---
        "browser.startup.page" = 3;
        "browser.tabs.warnOnClose" = false;
        "browser.download.useDownloadDir" = true;
        "browser.download.dir" = "${config.home.homeDirectory}/Downloads";
      };
    };
  };
}
