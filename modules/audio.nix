{ config, pkgs, ... } :
{
  security.rtkit.enable = true;
  services = { 
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    pulseaudio.enable = false;
  };
  environment.systemPackages = with pkgs; [
    pulseaudio
    pulsemixer
    tidal-hifi
  ];
}
