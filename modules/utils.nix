{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zip
    unzip
    wget
    curl
    tldr
    killall
    tree
    nix-index
    direnv
  ];

  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g mouse on 
    '';
  };
}
