{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # ==========================================================================
    # OPTIONS
    # ==========================================================================

    opts = {
      number = true;
      relativenumber = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      scrolloff = 8;
      swapfile = false;
      cursorline = true;
      wrap = false;
    };

    # ==========================================================================
    # PLUGINS
    # ==========================================================================

    plugins = {
      lualine.enable = true;

      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          clangd.enable = true;
          jdtls.enable = true;
          bashls.enable = true;
        };
      };

      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lsp_fallback = true;
            timeout_ms = 500;
          };
          formatters_by_ft = {
            nix = [ "nixfmt" ];
            c = [ "clang-format" ];
            cpp = [ "clang-format" ];
            java = [ "google-java-format" ];
            sh = [ "shfmt" ];
          };
        };
      };
    };

    # ==========================================================================
    # PACKAGES
    # ==========================================================================

    extraPackages = with pkgs; [
      nixd
      clang-tools
      jdt-language-server
      nodePackages.bash-language-server
      nixfmt
      google-java-format
      shfmt
    ];
  };
}
