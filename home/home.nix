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

  programs.rofi.enable = true;

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
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "kvantum";
  };

  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    catppuccin-kvantum
  ];
  
  home.file.".config/Kvantum/Catppuccin-Mocha".source =
    "${pkgs.catppuccin-kvantum}/share/Kvantum/Catppuccin-Mocha-Mauve";

  home.file.".config/Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Catppuccin-Mocha
  '';
  
  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
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
