{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # ============================================================================
    # GENERAL SETTINGS
    # ============================================================================
    opts = {
      number = true;
      relativenumber = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      smartindent = true;
      termguicolors = true;
      undofile = true;
      scrolloff = 8;
      signcolumn = "yes";
      updatetime = 250;
      swapfile = false;
      backup = false;
      wrap = false;
      cursorline = true;
    };

    globals.mapleader = " ";

    # ============================================================================
    # KEYMAPS
    # ============================================================================
    keymaps = [
      {
        mode = "n";
        key = "<C-e>";
        action = "<cmd>Neotree toggle<CR>";
      }
      {
        mode = "n";
        key = "<C-t>";
        action = "<cmd>ToggleTerm<CR>";
      }
      {
        mode = "t";
        key = "<C-t>";
        action = "<cmd>ToggleTerm<CR>";
      }
      {
        mode = "t";
        key = "<Esc>";
        action = "<C-\\><C-n>";
      }
    ];

    # ============================================================================
    # PLUGINS
    # ============================================================================
    plugins = {
      # --- UI & Visuals ---
      web-devicons.enable = true;
      alpha = {
        enable = true;
        theme = "dashboard";
      };
      lualine.enable = true;
      bufferline.enable = true;
      rainbow-delimiters.enable = true;
      indent-blankline.enable = true;
      illuminate.enable = true;
      nvim-colorizer.enable = true;
      todo-comments.enable = true;
      dressing.enable = true;
      which-key.enable = true;
      fidget.enable = true;

      # --- File Management ---
      neo-tree.enable = true;
      telescope = {
        enable = true;
        extensions.fzf-native.enable = true;
      };

      # --- Git ---
      gitsigns.enable = true;

      # --- Terminal ---
      toggleterm = {
        enable = true;
        settings = {
          direction = "horizontal";
          size = 15;
          open_mapping = "[[<C-t>]]";
        };
      };

      # --- Syntax Highlighting (Treesitter) ---
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          c
          cpp
          rust
          java
          javascript
          typescript
          tsx
          html
          css
          json
          nix
          python
        ];
      };

      # --- LSP & Language Support ---
      lsp = {
        enable = true;
        servers = {
          clangd.enable = true;
          jdtls.enable = true;
          ts_ls.enable = true;
          html.enable = true;
          cssls.enable = true;
          jsonls.enable = true;
          nixd.enable = true;
          pyright.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
        };
      };

      # --- Autocomplete (CMP) ---
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            {name = "nvim_lsp";}
            {name = "path";}
            {name = "buffer";}
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
          };
        };
      };
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      cmp-buffer.enable = true;
      nvim-autopairs.enable = true;

      # --- Debugging (DAP) ---
      dap.enable = true;
      dap-ui.enable = true;
      dap-virtual-text.enable = true;
      trouble.enable = true;

      # --- Formatting ---
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            c = ["clang-format"];
            cpp = ["clang-format"];
            rust = ["rustfmt"];
            java = ["google-java-format"];
            javascript = ["prettier"];
            typescript = ["prettier"];
            html = ["prettier"];
            css = ["prettier"];
            nix = ["alejandra"];
            python = ["black"];
          };
          format_on_save.lsp_fallback = true;
        };
      };
    };

    # ============================================================================
    # EXTRA PACKAGES (Build Tools & formatters)
    # ============================================================================
    extraPackages = with pkgs; [
      gcc
      clang-tools

      # Rust
      rust-analyzer
      cargo
      rustc
      rustfmt

      # JS/TS/Web
      nodePackages.typescript-language-server
      vscode-langservers-extracted
      nodePackages.prettier
      vscode-js-debug

      # Java
      jdt-language-server
      google-java-format

      # Python
      pyright
      black

      # Nix
      nixd
      alejandra

      # Misc
      lldb
      ripgrep
      fd
    ];
  };
}
