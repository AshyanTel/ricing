if status is-interactive

  #Adapt starship config to terminal used.
  switch $TERM
  case "linux"
    set -x STARSHIP_CONFIG $HOME/.config/starship/starship_tui.toml
  case "xterm-256color"
    set -x STARSHIP_CONFIG $HOME/.config/starship/starship_code.toml
  case "*"
    set -x STARSHIP_CONFIG $HOME/.config/starship/starship.toml
  end
  source (/run/current-system/sw/bin/starship init fish --print-full-init | psub)

  set fish_greeting ""
  set -x PATH $PATH $HOME/scripts

  #--- DAILY ALIAS ---#
  function cat -d "Alias to bat --pager never --style plain $args"
    bat --pager never --style plain --theme "Catppuccin Mocha" $argv
  end

  function ls -d "Alias to exa -l --git --icons $args"
    exa -l --git --icons $argv
  end

  function la -d "Alias to exa -lA --git --icons $args"
    exa -lA --git --icons $argv
  end

  #--- GIT ALIAS ---#
  function gitcd -d "Return to git project root"
    cd (git rev-parse --show-toplevel)
  end

  #--- NIX ALIAS ---#
  function nixd -d "Alias to nix develop -c fish"
    nix develop -c fish
  end

  function nix-garbage -d "Delete old generations and rebuild upgrading."
    sudo nix-collect-garbage --delete-old
  end

  function nix-rebuild-switch -d "Rebuild"
    git -C ~/ricing add .
    git -C ~/ricing commit -m "WIP"
    sudo nixos-rebuild switch --flake "$HOME/ricing#$HOSTNAME"
    source ~/ricing/fish/config.fish
  end
end
