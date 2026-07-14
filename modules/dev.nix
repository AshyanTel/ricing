{ config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    lazygit
    vscodium
    vscode
    rust-analyzer
  ];
}
