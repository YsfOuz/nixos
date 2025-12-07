{ pkgs, ... }:
{
  users.users.yusuf = {
    isNormalUser = true;
    description = "Yusuf Oğuz";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
  };
  programs.starship.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.noto
    nerd-fonts.fira-code
  ];  

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  programs.regreet.enable = true;
}
