{ pkgs, ... }:
{
  stylix = {
    enable = true;
    # image = ./verdigris.png;
    image = ./verdigrisMinimal.png;
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
        package = pkgs.iosevka;
        name = "Iosevka";
      };
      monospace = {
        package = pkgs.nerd-fonts.iosevka;
        name = "Iosevka Nerd Font";
      };
      serif = {
        package = pkgs.iosevka;
        name = "Iosevka";
      };
    };

    # ==========================================================================
    # OPACITY
    # ==========================================================================

    opacity = {
      applications = 1.0;
      desktop = 1.0;
      popups = 1.0;
      terminal = 1.0;
    };
  };
}
