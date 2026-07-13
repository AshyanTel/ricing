{ config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    prismlauncher
    moonlight-qt
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
