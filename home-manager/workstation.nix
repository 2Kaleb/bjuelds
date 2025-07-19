{ pkgs, pkgs-unstable, ... }:

{
  imports = [ ./common-cli.nix ./common-gui.nix ];
  home.packages = with pkgs; [
    pdfsam-basic
    zotero
    pkgs-unstable.zoom-us
    gimp
    libreoffice
    xournalpp
    miktex
  ];
}
