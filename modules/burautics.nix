{ config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    libroffice-fresh
    obsidian
  ];
};