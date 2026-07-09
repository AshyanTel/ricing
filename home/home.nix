{ config, pkgs, ... }:

{
  home.username = "ash";
  home.homeDirectory = "/home/ash";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  # Git config.
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "auxencemirliaz@ashyantel.dev";
        name = "ash";
        editor = "vim";
      };
      init.defaultBranch = "main";
      alias = {
        adog = "log --all --decorate --oneline --graph";
      };
    };
  };

  # Usage of vim plugs.
  home.file.".vim/autoload/plug.vim".source =
    "${pkgs.vimPlugins.vim-plug}/plug.vim";

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Mauve-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "standard";
        tweaks = [ ];
        variant = "mocha";
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = "pkgs.bibata-cursor";
      size = 24;
    };
  };

  # Safe usage of config files.
  home.file.".config/hypr".source = ../hypr;
  home.file.".config/kitty".source = ../kitty;
  home.file.".config/fish".source = ../fish;
  home.file.".config/waybar".source = ../waybar;
  home.file.".config/rofi".source = ../rofi;
  home.file.".config/rofimoji.rc".source = ../rofi/rofimoji.rc;
  home.file.".config/starship".source = ../starship;
  home.file.".vim/colors/raindrops.vim".source = ../vim/raindrops.vim;
}
