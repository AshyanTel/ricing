{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    lazygit
    vscodium
    vscode
    rust-analyzer
    jetbrains.idea
    jdk25
    (maven.override { jdk_headless = jdk25_headless; })
    gradle
  ];
}
