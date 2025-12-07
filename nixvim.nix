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
    viAlias = true;
    vimAlias = true;

    opts = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;
      ignorecase = true;
      smartcase = true;
      hlsearch = true;
      incsearch = true;
      termguicolors = true;
      cursorline = true;
      signcolumn = "yes";
      scrolloff = 8;
      clipboard = "unnamedplus";
      splitright = true;
      splitbelow = true;
      swapfile = false;
      backup = false;
    };
  };
}
