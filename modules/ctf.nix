{ config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    krita
    picocom
  ];
}
