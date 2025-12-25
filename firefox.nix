{ pkgs, ... }:

{
  stylix.targets.firefox.profileNames = [ "default" ];

  programs.firefox = {
    enable = true;

    profiles.default = {
      isDefault = true;

      search = {
        default = "ddg";
        engines = {
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
        "sidebar.verticalTabs" = true;
        "sidebar.visibility" = "expand-on-hover";

        # Performance
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;

        # ALL telemetry disabled
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.server" = "";
        "experiments.enabled" = false;
        "experiments.supported" = false;
        "network.allow-experiments" = false;

        # ALL AI features disabled
        "browser.ml.enable" = false;
        "browser.ml.chat.enabled" = false;
        "browser.ml.chat.sidebar" = false;

        # Clean homepage - ONLY search box
        "browser.newtabpage.activity-stream.showSearch" = true;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

        # Clear on shutdown - everything EXCEPT passwords & site settings
        "privacy.clearOnShutdown.cookies" = true;
        "privacy.clearOnShutdown.downloads" = true;
        "privacy.clearOnShutdown.history" = true;

        # Disable bloat
        "extensions.pocket.enabled" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.aboutwelcome.enabled" = false;

        # Privacy
        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
      };
    };
  };
}
