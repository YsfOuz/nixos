{ pkgs, ... }:
{
  stylix.targets.firefox.profileNames = [ "default" ];

  programs.firefox = {
    enable = true;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = false;
      DisableFirefoxScreenshots = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "never";
      SearchBar = "unified";

      # Privacy: Clean history on exit, but keep logins
      SanitizeOnShutdown = {
        Cache = true;
        Cookies = false; # KEEP FALSE to stay logged in
        History = true;
        Sessions = true; # Clears open tabs
        SiteSettings = false; # KEEP FALSE to preserve per-site permissions/zoom
        OfflineApps = true;
        Locked = true;
      };
    };

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
      ];

      # --- Search Engine Cleanup (Fixed IDs) ---
      search = {
        force = true;
        default = "ddg";
        order = [ "ddg" ];
        engines = {
          "google".metaData.hidden = true;
          "bing".metaData.hidden = true;
          "amazondotcom-us".metaData.hidden = true;
          "ebay".metaData.hidden = true;
          "wikipedia".metaData.hidden = true;

          # Built-in aliases for DuckDuckGo
          "ddg".metaData.alias = "@d";
        };
      };

      settings = {
        # --- Sidebar & Vertical Tabs ---
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "sidebar.expandOnHover" = true;
        "sidebar.visibility" = "expand-on-hover";
        "browser.tabs.inTitlebar" = 1;

        # Remove Tools from the sidebar configuration (First layer of defense)
        "sidebar.main.tools" = "";

        # --- Privacy & "Clean on Close" ---
        "privacy.sanitize.sanitizeOnShutdown" = true;
        "privacy.clearOnShutdown.history" = true;
        "privacy.clearOnShutdown.downloads" = true;
        "privacy.clearOnShutdown.formdata" = true;
        "privacy.clearOnShutdown.cache" = true;
        "privacy.clearOnShutdown.cookies" = false; # Keep cookies (logins)
        "privacy.clearOnShutdown.siteSettings" = false; # Keep site prefs
        "privacy.clearOnShutdown.sessions" = true;

        # --- UI Cleanup ---
        "browser.startup.page" = 3;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.newtabpage.enabled" = true;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.default.sites" = "";

        # --- Performance ---
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.server" = "data:,";
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "browser.ping-centre.telemetry" = false;
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "gfx.canvas.accelerated" = true;
      };

      # CSS to Force Hide Sidebar Tools & Specific Toolbar Buttons
      userChrome = ''
        /* --- Hide Sidebar Tools (AI, History, Synced Tabs) --- */
        /* Hides the bottom container in the new sidebar */
        #sidebar-main-tools, 
        .sidebar-tools-container, 
        #sidebar-switcher-target { 
            display: none !important; 
        }

        /* --- Toolbar Cleanup --- */
        /* Hide Home Button */
        #home-button { display: none !important; }

        /* Hide Library/History Button */
        #library-button { display: none !important; }

        /* Hide Firefox View (Tab icon) */
        #firefox-view-button { display: none !important; }

        /* Hide the "Sidebar" button from the top toolbar */
        #sidebar-button { display: none !important; }

        /* Note: Flexible spaces (toolbarspring) are visible again! */
      '';
    };
  };
}
