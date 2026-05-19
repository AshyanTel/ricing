if status is-interactive
  
  # Prompt Starship.rs
  # Change the prompt with the terminal used.
  if test $TERM = "linux"
    set -x STARSHIP_CONFIG $HOME/.config/starship_tui.toml
  else if test $TERM = "xterm-256color"
    set -x STARSHIP_CONFIG $HOME/.config/starship_code.toml
  else
    set -x STARSHIP_CONFIG $HOME/.config/starship.toml
  end
  source (/usr/bin/starship init fish --print-full-init | psub)
 
   
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

end
