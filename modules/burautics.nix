{ config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    libreoffice-fresh
    obsidian
    onlyoffice-desktopeditors
  ];
}
