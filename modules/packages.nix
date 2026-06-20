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
}
