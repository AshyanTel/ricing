{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    hypridle
    hyprlock
    hyprshot
    hyprpicker
    waypaper
    mpvpaper
    firefox
    kitty
    waybar
    rofi-unwrapped
    rofi-calc
    rofimoji
    rofi-nerdy
    rofi-power-menu
    mako
    vesktop
    signal-desktop
    obsidian
    pavucontrol
    bluetui
    vscodium
    libreoffice-fresh
    hyphenDicts.fr-fr
    yazi
    yaziPlugins.git
    yaziPlugins.diff
    yaziPlugins.office

  ];
}
