{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    hypridle
    hyprlock
    hyprshot
    hyprpicker
    mpvpaper
    kitty
    waybar
    rofi
    rofi-calc
    rofimoji
    rofi-nerdy
    rofi-power-menu
    mako
    pavucontrol
    bluetui
    firefox
    librewolf
    yazi
    yaziPlugins.git
    yaziPlugins.diff
    yaziPlugins.office
    papirus-icon-theme
    adwaita-icon-theme
    adwaita-qt
    streamcontroller
    jq
  ];
}
