{ config, pkgs, ... }:

{
  home = {
    username = "ash";
    homeDirectory = "/home/ash";
    stateVersion = "26.05";
    packages = with pkgs; [
      libsForQt5.qtstyleplugin-kvantum
      kdePackages.qtstyleplugin-kvantum
      catppuccin-kvantum
    ];

    sessionVariables = {
      XCURSOR_THEME = "Bibata-Modern-Ice";
      XCURSOR_SIZE = "24";
    };
  
  security.pam.services = {
    ly.fprintAuth = true;
    hyprlock.fprintAuth = true;
  };

  # Safe usage of config files.
  file = { 
    ".config/Kvantum/Catppuccin-Mocha".source =
    "${pkgs.catppuccin-kvantum}/share/Kvantum/Catppuccin-Mocha-Mauve";

    ".config/Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Catppuccin-Mocha
    '';



    ".config/hypr".source = ../hypr;
    ".config/kitty".source = ../kitty;
    ".config/fish".source = ../fish;
    ".config/waybar".source = ../waybar;
    ".config/rofi".source = ../rofi;
    ".config/rofimoji.rc".source = ../rofi/rofimoji.rc;
    ".config/starship".source = ../starship;
    ".vim/colors/raindrops.vim".source = ../vim/raindrops.vim;
    };
    };

    programs = {
      home-manager.enable = true;

  # Git config.
  git = {
    enable = true;
    settings = {
      user = {
        email = "auxencemirliaz@ashyantel.dev";
        name = "ash";
      };
      core.editor = "vim";
      init.defaultBranch = "main";
      alias = {
        adog = "log --all --decorate --oneline --graph";
      };
    };
  };
  rofi.enable = true;
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
        package = pkgs.bibata-cursors;
        size = 24;
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "gtk3";
      style.name = "kvantum";
    };

  }
