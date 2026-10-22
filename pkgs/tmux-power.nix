{ lib, tmuxPlugins, fetchFromGitHub }:

tmuxPlugins.mkTmuxPlugin {
  pluginName = "tmux-power";
  version = "unstable";
  rtpFilePath = "tmux-power.tmux";

  src = fetchFromGitHub {
    owner = "wfxr";
    repo = "tmux-power";
    rev ="d69c4d7ffc64828ac5ac4b3056dacdd7ef51997f";
    hash = "sha256-NRJcny3hCyqjp8SuzyC3Zc33rJqpUzs6rbWFgO8yb7c=";
  };

  meta = {
    description = "Powerline theme for tmux";
    homepage = "https://github.com/wfxr/tmux-power";
    license = lib.licenses.mit;
  };
}
