{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.rofi = {
    enable = true;
    cycle = true;
    font = lib.mkForce "NotoSans Nerd Font 12";
    plugins = with pkgs; [
      rofi-calc
      rofi-emoji
    ];

    extraConfig = {
      modi = "drun,run,window,calc,emoji";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      disable-history = false;
      sidebar-mode = false;
    };

    # Manual Theme Override
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "window" = {
          transparency = "real";
          width = mkLiteral "500px";
          border-radius = mkLiteral "5px";
          border = mkLiteral "2px";
          padding = mkLiteral "10px";
        };
        "mainbox" = {
          children = map mkLiteral [
            "inputbar"
            "listview"
          ];
          spacing = mkLiteral "15px";
          background-color = mkLiteral "transparent";
        };
        "inputbar" = {
          children = map mkLiteral [ "entry" ];
          border-radius = mkLiteral "5px";
          padding = mkLiteral "12px";
          background-color = mkLiteral "transparent";
        };
        "entry" = {
          background-color = mkLiteral "transparent";
        };
        "listview" = {
          columns = 1;
          lines = 8;
          scrollbar = false;
          spacing = mkLiteral "5px";
          background-color = mkLiteral "transparent";
        };
        "element" = {
          padding = mkLiteral "10px";
          border-radius = mkLiteral "5px";
          spacing = mkLiteral "10px";
          background-color = mkLiteral "transparent";
        };
        "element-icon" = {
          size = mkLiteral "32px";
          background-color = lib.mkForce (mkLiteral "transparent");
        };
        "element-text" = {
          vertical-align = mkLiteral "0.5";
          background-color = lib.mkForce (mkLiteral "transparent");
        };
      };
  };
}
