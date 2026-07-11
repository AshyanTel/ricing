{ config, lib, pkgs, self, ... }:
let
  dotfiles = ../../dotfiles;
  dotfilesDirs = builtins.attrNames (builtins.readDir dotfiles);
in
{
  home = {
    username = "ash";
    homeDirectory = "/home/ash";
    stateVersion = "26.05";
    packages =  [
      pkgs.libsForQt5.qtstyleplugin-kvantum
      pkgs.kdePackages.qtstyleplugin-kvantum
      pkgs.catppuccin-kvantum
      (pkgs.callPackage "${self}/pkgs/nmtui-go.nix" { })
    ];
    pointerCursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 20;
      gtk.enable = true;
      x11.enable = true;
    };

    sessionVariables = {
      EDITOR = "vim";
    };
  
    # Usage of vim plugs.
    file.".vim/autoload/plug.vim".source =
      "${pkgs.vimPlugins.vim-plug}/plug.vim";


    xdg.configFile = lib.genAttrs dotfilesDirs (name : {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${name}";
    });
    file = { 
      ".config/user".source = ../user.png;
      ".vim/colors/raindrops.vim".source = ../vim/raindrops.vim;
    };
  };

  programs = {
    # Enable home manager it self.. trust...
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
