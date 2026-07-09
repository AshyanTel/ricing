{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    hypridle
    hyprlock
    hyprshot
    hyprpicker
    waypaper
    mpvpaper
    kitty
    waybar
    rofi-calc
    rofimoji
    rofi-nerdy
    rofi-power-menu
    librsvg
    gdk-pixbuf
    mako
    pavucontrol
    bluetui
    firefox
    yazi
    yaziPlugins.git
    yaziPlugins.diff
    yaziPlugins.office
    papirus-icon-theme
    adwaita-icon-theme
    adwaita-qt
  ];

  environment.sessionVariables = {
    GTK_ICON_THEME = "Papirus";
  };
}
