{ pkgs, ... }:

{
  imports = [ ./common-cli.nix ./common-gui.nix ];
  home.packages = with pkgs; [
    czkawka
    baobab
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
