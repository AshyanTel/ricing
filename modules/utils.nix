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
  ];
}
