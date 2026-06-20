{ config, pkgs, ... }:

{
  home.username = "ash";
  home.homeDirectory = "/home/ash";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings.user = {
      email = "auxencemirliaz@ashyantel.dev";
      name = "ash";
    };
  };
  home.file.".vim/autoload/plug.vim".source =
    "${pkgs.vimPlugins.vim-plug}/plug.vim";
  home.file.".config/hypr".source = ../hypr;
  home.file.".config/kitty".source = ../kitty;
  home.file.".config/fish".source = ../fish;
  home.file.".config/waybar".source = ../waybar;
  home.file.".config/rofi".source = ../rofi;
  home.file.".config/starship".source = ../starship;
  home.file.".vim/colors/raindrops.vim".source = ../vim/raindrops.vim;
}
