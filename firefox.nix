{ pkgs, ... }:
{
  # 1. Disable Stylix (Crucial)
  stylix.targets.firefox.enable = false;

  programs.firefox = {
    enable = true;
    
    profiles.yusuf = {
      id = 0;
      name = "yusuf";
      isDefault = true;

      # 2. SEARCH (Kept your working 'ddg' fix)
      search = {
        force = true;
        default = "ddg"; 
        privateDefault = "ddg";
        engines = {
          "ddg" = {
            metaData.alias = "@d";
            urls = [{ template = "https://duckduckgo.com/?q={searchTerms}"; }];
          };
          "google".metaData.hidden = true;
          "bing".metaData.hidden = true;
          "amazondotcom-us".metaData.hidden = true;
          "ebay".metaData.hidden = true;
          "wikipedia".metaData.hidden = true;
        };
      };

      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
      ];

      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # 3. YOUR VERTICAL TABS FIX (Kept exactly as you had it)
        "sidebar.main.tools" = "";
        "sidebar.verticalTabs" = true;
        "sidebar.visibility" = "expand-on-hover"; # 

        # 4. FORCE TOOLBAR ORDER (The Magic Fix)
        # This JSON string forces: Back -> Forward -> Reload -> URL -> Downloads -> Extensions
        "browser.uiCustomization.state" = ''
          {"placements":{"widget-overflow-fixed-list":[],"nav-bar":["back-button","forward-button","stop-reload-button","urlbar-container","downloads-button","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["developer-button"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar"],"currentVersion":18,"newElementCount":4}
        '';

        # 5. GENERAL SETTINGS
        "browser.ml.enable" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.tabs.firefox-view" = false;
        "extensions.pocket.enabled" = false;
        "browser.download.autohideButton" = false; # Keep Downloads visible
      };

      # 6. CSS (Just to hide the unmovable buttons)
      userChrome = ''
        /* Hide "List all tabs" button */
        #alltabs-button { display: none !important; }
        
        /* Hide Home Button (if it appears) */
        #home-button { display: none !important; }
        
        /* Hide Pocket */
        #pocket-button { display: none !important; }

        /* Hide Titlebar */
        #titlebar { display: none !important; }
      '';
    };
    
    # 7. POLICIES
    policies = {
      DisableTelemetry = true;
      DisablePocket = true;
      SearchEngines = {
        Default = "DuckDuckGo"; 
        PreventInstalls = true;
      };
    };
  };
}
