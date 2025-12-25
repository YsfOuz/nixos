{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # Only set options that differ from neovim defaults for IDE use
    opts = {
      number = true;
      relativenumber = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      smartindent = true;
      
      # Required for stylix colors
      termguicolors = true;
      
      # Quality of life
      undofile = true;
      scrolloff = 8;
      signcolumn = "yes";
      updatetime = 250;
      
      # Disable defaults we don't need
      swapfile = false;
      backup = false;
      wrap = false;
      hlsearch = false;
    };

    globals.mapleader = " ";

    # Keymaps - only essential IDE bindings
    keymaps = [
      # File explorer
      { mode = "n"; key = "<leader>e"; action = "<cmd>Neotree toggle<CR>"; }
      
      # Terminal
      { mode = "n"; key = "<leader>t"; action = "<cmd>ToggleTerm<CR>"; }
      { mode = "t"; key = "<C-x>"; action = "<C-\\><C-n>"; }
      
      # Buffers
      { mode = "n"; key = "<S-l>"; action = "<cmd>bnext<CR>"; }
      { mode = "n"; key = "<S-h>"; action = "<cmd>bprevious<CR>"; }
      { mode = "n"; key = "<leader>x"; action = "<cmd>bdelete<CR>"; }
      
      # Window navigation
      { mode = "n"; key = "<C-h>"; action = "<C-w>h"; }
      { mode = "n"; key = "<C-j>"; action = "<C-w>j"; }
      { mode = "n"; key = "<C-k>"; action = "<C-w>k"; }
      { mode = "n"; key = "<C-l>"; action = "<C-w>l"; }
      
      # Telescope
      { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<CR>"; }
      { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<CR>"; }
      { mode = "n"; key = "<leader>fb"; action = "<cmd>Telescope buffers<CR>"; }
      
      # LSP
      { mode = "n"; key = "gd"; action = "<cmd>lua vim.lsp.buf.definition()<CR>"; }
      { mode = "n"; key = "gr"; action = "<cmd>lua vim.lsp.buf.references()<CR>"; }
      { mode = "n"; key = "K"; action = "<cmd>lua vim.lsp.buf.hover()<CR>"; }
      { mode = "n"; key = "<leader>ca"; action = "<cmd>lua vim.lsp.buf.code_action()<CR>"; }
      { mode = "n"; key = "<leader>rn"; action = "<cmd>lua vim.lsp.buf.rename()<CR>"; }
      { mode = "n"; key = "[d"; action = "<cmd>lua vim.diagnostic.goto_prev()<CR>"; }
      { mode = "n"; key = "]d"; action = "<cmd>lua vim.diagnostic.goto_next()<CR>"; }
    ];

    plugins = {
      # Icons (required by neo-tree, telescope, bufferline)
      web-devicons.enable = true;

      # File tree
      neo-tree = {
        enable = true;
        settings = {
          close_if_last_window = true;
          };
        };
      };

      # Terminal
      toggleterm = {
        enable = true;
        settings = {
          direction = "horizontal";
          close_on_exit = true;
        };
      };

      # Statusline (stylix themed)
      lualine.enable = true;

      # Bufferline (stylix themed)
      bufferline = {
        enable = true;
        settings.options = {
          diagnostics = "nvim_lsp";
          offsets = [{
            filetype = "neo-tree";
            text = "File Explorer";
            text_align = "center";
          }];
        };
      };

      # Fuzzy finder
      telescope = {
        enable = true;
        extensions.fzf-native.enable = true;
      };

      # Syntax highlighting
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          java cpp rust javascript typescript tsx html css json
        ];
      };

      # LSP
      lsp = {
        enable = true;
        servers = {
          jdtls.enable = true;
          clangd = {
            enable = true;
            cmd = [ "${pkgs.clang-tools}/bin/clangd" ];
          };
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          ts_ls.enable = true;
          html.enable = true;
          cssls.enable = true;
          jsonls.enable = true;
        };
      };

      # Completion
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          mapping = {
            __raw = ''
              cmp.mapping.preset.insert({
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
              })
            '';
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
      };

      # Essential IDE features
      nvim-autopairs.enable = true;
      comment.enable = true;
      gitsigns.enable = true;
      indent-blankline.enable = true;
      which-key.enable = true;

      # Formatting
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            java = [ "google-java-format" ];
            cpp = [ "clang-format" ];
            c = [ "clang-format" ];
            rust = [ "rustfmt" ];
            javascript = [ "prettier" ];
            typescript = [ "prettier" ];
            html = [ "prettier" ];
            css = [ "prettier" ];
          };
          format_on_save.lsp_fallback = true;
        };
      };
    };

    # Language tools
    extraPackages = with pkgs; [
      # Core build tools
      gcc
      
      # Language servers & formatters
      jdt-language-server
      google-java-format
      clang-tools
      rust-analyzer
      rustfmt
      nodePackages.typescript-language-server
      nodePackages.prettier
      vscode-langservers-extracted
      
      # Search tools
      ripgrep
      fd
    ];
  };
}
