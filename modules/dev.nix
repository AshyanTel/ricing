{ config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    lazygit
    vscodium
    rust-analyzer
  ];
}
