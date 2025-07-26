{ pkgs, pkgs-unstable, ... }:

{
  imports = [ ./common-cli.nix ./common-gui.nix ];
  home.packages = with pkgs; [
    pdfsam-basic
    zotero
    pkgs-unstable.zoom-us
    gimp
    libreoffice
    onlyoffice-desktopeditors
    kdePackages.ark
    xournalpp
    rnote
    github-desktop
    miktex
    ashpd-demo
    door-knocker
    obsidian
    pwvucontrol
    wasistlos
  ];
}
