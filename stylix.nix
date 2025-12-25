{ pkgs, ... }:
{
  stylix = {
    enable = true;
    image = ./verdigris.png;
    base16Scheme = ./verdigris.yaml;
    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    fonts = {
      monospace.name = "FiraCode Nerd Font Mono";
      sansSerif.name = "NotoSans Nerd Font";
      serif.name = "NotoSans Nerd Font";
    };

    opacity = {
      applications = 0.5;
      desktop = 0.5;
      popups = 0.5;
      terminal = 0.5;
    };
  };
}
