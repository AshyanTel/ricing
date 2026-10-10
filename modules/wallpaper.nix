{ lib, ...}:
{
  options.wallpaper = lib.mkOption {
    type = lib.types.path;
    description = "Fond d'écran commun (greeter et hyprland),";
  };
}
