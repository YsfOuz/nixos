{ pkgs, ... }:
{
  stylix.targets.nixvim = {
    plugin = "base16-nvim";
    transparentBackground = {
      main = true;
      numberLine = true;
      signColumn = true;
    };
  };
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    opts = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;
      ignorecase = true;
      smartcase = true;
      incsearch = true;
      cursorline = true;
      scrolloff = 12;
      swapfile = false;
      backup = false;
    };
    clipboard.register = "unnamedplus";
    highlight = {
      Normal = {
        bg = "none";
        ctermbg = "none";
      };
      NormalNC = {
        bg = "none";
        ctermbg = "none";
      };
    };
    keymaps = [
      {
        mode = [
          "n"
          "t"
        ];
        key = "<C-Tab>";
        action = "<cmd>wincmd w<cr>";
        options = {
          desc = "Cycle Window Focus";
          silent = true;
        };
      }
      {
        key = "<C-e>";
        action = "<cmd>Neotree toggle<cr>";
        options = {
          desc = "Toggle Explorer";
          silent = true;
        };
      }
    ];
    plugins = {
      treesitter = {
        enable = true;
        settings = {
          ensure_installed = [
            "java"
            "cpp"
            "rust"
            "html"
            "css"
            "javascript"
            "typescript"
            "nix"
            "markdown"
          ];
          highlight.enable = true;
        };
      };
      luasnip.enable = true;
      friendly-snippets.enable = true;
      lsp = {
        enable = true;
        servers = {
          jdtls.enable = true;
          clangd.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          ts_ls.enable = true;
          html.enable = true;
          cssls.enable = true;
          nixd.enable = true;
        };
      };
      cmp = {
        enable = true;
        autoEnableSources = true; # Automatically enables installed sources
        settings = {
          sources = [
            { name = "nvim_lsp"; } # From your LSP servers (rust, java, etc.)
            { name = "path"; } # File system paths
            { name = "buffer"; } # Words in the current file
            { name = "luasnip"; } # Snippets
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
          };
        };
      };
      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            timeout_ms = 500;
            lsp_fallback = true;
          };
          formatters_by_ft = {
            java = [ "google-java-format" ];
            rust = [ "rustfmt" ];
            html = [ "prettier" ];
            css = [ "prettier" ];
            javascript = [ "prettier" ];
            typescript = [ "prettier" ];
            nix = [ "nixfmt" ];
          };
        };
      };
      gitsigns.enable = true;
      nvim-autopairs.enable = true;
      comment.enable = true;
      colorizer.enable = true;
      flash.enable = true;
      telescope.enable = true;
      neo-tree = {
        enable = true;
        settings = {
          closeIfLastWindow = true;
        };
      };
      toggleterm = {
        enable = true;
        settings = {
          shade_terminals = false;
          open_mapping = "[[<C-t>]]";
        };
      };
      oil.enable = true;
      which-key.enable = true;
      alpha = {
        enable = true;
        theme = "dashboard";
      };
      noice.enable = true;
      lualine.enable = true;
      bufferline.enable = true;
      dressing.enable = true;
      todo-comments.enable = true;
      rainbow-delimiters.enable = true;
      indent-blankline = {
        enable = true;
        settings = {
          scope = {
            show_end = true;
            show_exact_scope = true;
          };
        };
      };
      web-devicons.enable = true;
    };
    extraPackages = with pkgs; [
      jdk
      jdt-language-server
      google-java-format
      gcc
      clang-tools
      rustc
      cargo
      rust-analyzer
      rustfmt
      nodejs
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.prettier
      nixd
      nixfmt
    ];
  };
}
