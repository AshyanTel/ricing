if status is-interactive
  
  # Prompt Starship.rs
  # Change the prompt with the terminal used.
  if test $TERM = "linux"
    set -x STARSHIP_CONFIG $HOME/.config/starship/starship_tui.toml
  else if test $TERM = "xterm-256color"
    set -x STARSHIP_CONFIG $HOME/.config/starship/starship_code.toml
  else
    set -x STARSHIP_CONFIG $HOME/.config/starship/starship.toml
  end

  source (/run/current-system/sw/bin/starship init fish --print-full-init | psub)
  function cat
    bat --pager never --style plain $argv
  end

  function ls
    exa -l --git --icons $argv
  end

  function la
    exa -li --git --icons $argv
  end

  function cdd
    cd (git root)
  end

  function rars
    env _JAVA_OPTIONS="-Dsun.java2d.uiScale=2 -Dsun.java2d.dpiaware=true -Dsun.java2d.xrender=true" java -jar /home/ash/inf/4170/rars-flatlaf.jar
  end
  
  set -x PATH $PATH $HOME/scripts /home/ash/.local/share/gem/ruby/3.4.0/bin

  set fish_greeting ""
  
  function auto_venv --on-variable PWD
    set -l dir $PWD
    set -l found_venv

    while test "$dir" != "/"
        if test -f "$dir/.venv/bin/activate.fish"
            set found_venv "$dir/.venv"
            break
        end

        set dir (dirname "$dir")
    end

    if test -n "$found_venv"
        # Active seulement si ce n'est pas déjà le bon venv
        if test "$VIRTUAL_ENV" != "$found_venv"
            if functions -q deactivate
                deactivate
            end
            source "$found_venv/bin/activate.fish"
        end
    else
        # Aucun .venv trouvé -> désactivation
        if functions -q deactivate
            deactivate
        end
    end
  end

  function nixd
    nix develop -c fish -C "source .venv/bin/activate.fish"
  end
    
  function nix-clean
    sudo nix-env --delete-generations old
  end

  function nix-switch
    sudo nixos-rebuild switch --flake "$HOME/ricing#$args"
  end
end

# Created by `pipx` on 2026-05-29 19:34:36
# set PATH $VENV/bin $PATH $HOME/.local/bin $HOME/.cargo/bin 
