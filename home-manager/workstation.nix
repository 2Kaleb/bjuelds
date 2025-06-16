{ pkgs, pkgs-unstable, ... }:

{
  imports = [ ./common-cli.nix ./common-gui.nix ];
  home.packages = with pkgs; [
    pdfsam-basic
    zotero
    pkgs-unstable.zoom-us
    gimp
    libreoffice
    element-desktop
    jetbrains.pycharm-community-bin
    kdePackages.ark
    xournalpp
    code-cursor
    wechat-uos
    gnuclad
    drawio
    pympress
    github-desktop
    miktex
    nextcloud-client
  ];
}
