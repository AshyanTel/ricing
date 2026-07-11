{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    wget
    eza
    fastfetch
    bat
    btop
    hwloc
  ];
}
