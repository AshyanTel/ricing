{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    wget
    git
    vim-full
    vimPlugins.vim-plug
    eza
    fastfetch
    bat
    btop
    hwloc
  ];

  programs = {
    vim = {
      enable = true;
      extraConfig = builtins.readFile ../vim/vimrc.vim;
    };
  };
}
