{ pkgs, ... }:
{
  stylix = {
    enable = true;
    image = ./verdigris.png;
    base16Scheme = ./verdigris.yaml;
    polarity = "dark";

    # ==========================================================================
    # CURSOR & ICONS
    # ==========================================================================

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

    # ==========================================================================
    # FONTS
    # ==========================================================================

    fonts = {
      sansSerif = {
        package = pkgs.recursive;
        name = "Recursive Sans Casual Static";
      };
      monospace = {
        package = pkgs.nerd-fonts.recursive-mono;
        name = "RecMonoCasual Nerd Font";
      };
      serif = {
        package = pkgs.recursive;
        name = "Recursive Sans Casual Static";
      };
      sizes = {
        desktop = 12;
      };
    };

    # ==========================================================================
    # OPACITY
    # ==========================================================================

    opacity = {
      applications = 0.75;
      desktop = 0.75;
      popups = 0.75;
      terminal = 0.75;
    };
  };
}
