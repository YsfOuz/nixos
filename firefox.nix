{ pkgs, ... }:
{
  stylix.targets.firefox.profileNames = [ "default" ];
  programs.firefox = {
    enable = true;

    # Extensions
    policies.ExtensionSettings = {
      "uBlock0@raymondhill.net" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        installation_mode = "force_installed";
      };
    };

    profiles.default = {
      id = 0;
      isDefault = true;

      # Search engine
      search = {
        default = "ddg";
        privateDefault = "ddg";
        force = true;
      };

      settings = {

        # AI / ML
        "browser.ai.control.default" = "blocked";

        # Telemetry / data reporting
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.usage.uploadEnabled" = false;
        "browser.search.serpEventTelemetryCategorization.regionEnabled" = false;

        # Privacy / sanitize on shutdown
        "privacy.sanitize.sanitizeOnShutdown" = true;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "places.history.enabled" = false;

        # Forms / passwords / autofill
        "browser.formfill.enable" = false;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "signon.generation.enabled" = false;
        "signon.firefoxRelay.feature" = "disabled";

        # New tab
        "browser.newtabpage.activity-stream.feeds.topsites" = false;

        # URL bar
        "browser.urlbar.suggest.bookmark" = false;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.quickactions" = false;
        "browser.urlbar.suggest.recentsearches" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.urlbar.shortcuts.actions" = false;
        "browser.urlbar.shortcuts.bookmarks" = false;
        "browser.urlbar.shortcuts.history" = false;
        "browser.urlbar.shortcuts.tabs" = false;
        "browser.urlbar.showSearchSuggestionsFirst" = false;
        "browser.search.suggest.enabled.private" = true;

        # UI / sidebar
        "sidebar.verticalTabs" = true;
        "sidebar.revamp" = true;
        "sidebar.visibility" = "expand-on-hover";
        "browser.tabs.groups.smart.userEnabled" = false;
        "browser.theme.toolbar-theme" = 0;
      };
    };
  };
}
