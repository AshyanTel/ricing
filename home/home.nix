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
    pointerCursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 20;
      gtk.enable = true;
      x11.enable = true;
    };

  # Safe usage of config files.
  file = { 
    ".config/user".source = ../user.png;
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

    catppuccin = {
      enable = true;
      autoEnable = true;
      flavor = "mocha";
      accent = "mauve";
    };

    gtk = {
      enable = true;
      theme = {
        name = "catppuccin-mocha-mauve-standard";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "mauve" ];
          size = "standard";
          tweaks = [ ];
          variant = "mocha";
        };
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };

      cursorTheme = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
        size = 20;
      };
    };

    dconf.enable = true;
    dconf.settings."org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "catppuccin-mocha-mauve-standard";
    };

    qt = {
      enable = true;
      platformTheme.name = "gtk3";
      style.name = "kvantum";
    };
  }
