{ pkgs, ... }:

{
  imports = [
    ./common-cli.nix
    ./common-gui.nix
  ];
  home.packages = with pkgs; [
    czkawka
    gparted
    furmark
    unigine-superposition
    geekbench
    kdiskmark
    fio
    speedtest-cli
    # ookla-speedtest
    smartmontools
  ];
}
