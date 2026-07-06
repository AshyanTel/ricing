{ config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    vscodium
    vscode
    rust-analyzer
  ];
}
