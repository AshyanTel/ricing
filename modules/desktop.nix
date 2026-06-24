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
    hyphen
    hyphenDicts.fr_FR
    yazi
    yaziPlugins.git
    yaziPlugins.diff
    yaziPlugins.office
    papirus-icon-theme
    adwaita-icon-theme
    adwaita-qt
    tidal-hifi
    widevine-cdm
    ankama-launcher
    prismlauncher
  ];

  environment.sessionVariables = {
    GTK_ICON_THEME = "Papirus";
  };
}
