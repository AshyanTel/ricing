{ inputs, config, lib, pkgs, self, ... }:

let
    configPath = ./config;
    dotfilesDir = "${config.home.homeDirectory}/dots";
    configDir = builtins.attrNames (builtins.readDir configPath);

    yazi-plugins = pkgs.fetchFromGitHub {
        owner = "yazi-rs";
        repo = "plugins";
        rev = "6229767f7fef39a2a78f5cee9122cc4dfb43f327";
        hash = "sha256-/BNGoWziHIZ9i+RoTWGq/q3ZowNCyHGBOWiz8v2/vOE=";
    };
    yazi-flavors = pkgs.fetchFromGitHub {
        owner = "yazi-rs";
        repo = "flavors";
        rev = "1183892c904f7f0efdf4473e856ed308b7bea98d"; 
        hash = "sha256-E1OUF1+mT0V3crVxkewG2Y7hRu8fO+0oRl6NlINmw+o=";
    };
    yaziline = pkgs.fetchFromGitHub {
    	owner = "llanosrocas";
    	repo = "yaziline.yazi";
    	rev = "029b27d55361b4b87d0982237f9730b49b4e7a3a";
    	hash = "sha256-oYvbhAi1xHn8XKgnwBYrHBqRReX4kJDkmSTs15RS/2U=";
    };
in
{
  imports = [ ./modules/wallpaper.nix ];
  
  wallpaper = ./config/wallpapers/wallhaven-vp22dm.jpg;
  home = {
    username = "ash";
    homeDirectory = "/home/ash";
    stateVersion = "26.05";
    packages =  [
        pkgs.libsForQt5.qtstyleplugin-kvantum
        pkgs.kdePackages.qtstyleplugin-kvantum
        pkgs.catppuccin-kvantum

        pkgs.tree-sitter
        pkgs.prettier
        pkgs.markdownlint-cli2
        pkgs.marksman
        pkgs.gcc
        pkgs.lua-language-server
        pkgs.jdt-language-server
        pkgs.clang-tools
        pkgs.rust-analyzer
        pkgs.nixd
        pkgs.bash-language-server
        pkgs.shellcheck
        pkgs.fish-lsp
        pkgs.fzf
        pkgs.ripgrep
        pkgs.nodejs
        pkgs.cargo
        pkgs.rustc
        
        (pkgs.python3.withPackages (ps: with ps; [
          pynvim
          jupyter-client
          ipykernel
          pylatexenc
          matplotlib
          numpy
          scipy
          scikit-image
          imageio
          jupytext
        ]))        
        pkgs.pyright
        pkgs.imagemagick
        pkgs.luajitPackages.magick

        (pkgs.callPackage "${self}/pkgs/nmtui-go.nix" { })
        (pkgs.callPackage "${self}/pkgs/ankama-launcher.nix" { })
        (pkgs.callPackage "${self}/pkgs/rarsm.nix" { })
        (pkgs.callPackage "${self}/pkgs/bluej.nix" { })
        ];
    pointerCursor = {
      enable = true;
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 20;
      gtk.enable = true;
      x11.enable = true;
    };

    sessionVariables = {
      EDITOR = "nvim";
    };
  };


  home.file.".config/user".source = ./user.png;

  xdg.configFile = lib.genAttrs configDir (name : {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/${name}";
  }) // {
    "wallpaper.png".source = config.wallpaper;
  };

  xdg.dataFile."hyprland/hl.meta.lua".source =
    pkgs.runCommand "hl.meta.lua" { nativeBuildInputs = [ pkgs.python3 ]; } ''
      python3 ${inputs.hyprland-src}/meta/generateLuaStubs.py \
      --root ${inputs.hyprland-src} \
      --output $out
    '';

  xdg.desktopEntries.rars = {
    name = "RARS";
    exec = "rars";
    icon = "utilities-terminal";
    comment = "RISC-V Assembler and Runtime Simulator";
    categories = [ "Development" ];
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
                core.editor = "nvim";
                init.defaultBranch = "main";
                alias = {
                  adog = "log --all --decorate --oneline --graph";
                };
            };
        };

      quickshell = {
        enable = true;
      };

      tmux = {
        enable = true;
        plugins = [
        {
          plugin = pkgs.callPackage ./pkgs/tmux-power.nix { };

          extraConfig = ''
            set -g @tmux_power_theme "#cba6f7"
            set -g @tmux_power_g0 "#181825"
            set -g @tmux_power_g1 "#1e1e2e"
            set -g @tmux_power_g2 "#313244"
            set -g @tmux_power_g3 "#45475a"
            set -g @tmux_power_g4 "#585b70"
            '';
        }
        ];

        extraConfig = ''
          set -g mouse on
          set -g window-size smallest
          set -g focus-events on
          set -ga terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'
          set -g default-terminal "tmux-256color"
          set -as terminal-features ",*:RGB"
          set -g allow-passthrough on 
          unbind -T copy-mode MouseDragEnd1Pane
          bind -T copy-mode MouseDragEnd1Pane send -X copy-selection-no-clear
          '';
      };
      yazi = {
          enable = true;
          theme = {
            flavor.dark = "catppuccin-mocha";
            indicator.padding = {
              open = builtins.fromJSON ''"\ue0b2"'';
              close = builtins.fromJSON ''"\ue0b0"'';
            };
            status = {
              sep_left = {
                open = "";
                close = builtins.fromJSON ''"\ue0b0"'';
              };
              sep_right = {
                open = builtins.fromJSON ''"\ue0b2"'';
                close = "";
              };
            };
          };
          flavors.catppuccin-mocha = "${yazi-flavors}/catppuccin-mocha.yazi";
          plugins = {
            full-border = "${yazi-plugins}/full-border.yazi";
            yaziline = yaziline;
          };
          initLua = ''
                  require("full-border"):setup {
                  type = ui.Border.PLAIN,
              }
          '';
      };
      neovim = {
        enable = true;
        withPython3 = true;
        extraPython3Packages = ps: with ps; [
          pynvim
          jupyter-client
          ipykernel
          pylatexenc
          matplotlib
          imageio
          scipy
          scikit-image
          numpy
        ];
        sideloadInitLua = true;
      };
    };

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "mauve";
    yazi.enable = false;
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
