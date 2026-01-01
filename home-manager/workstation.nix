{ pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./common-cli.nix
    ./common-gui.nix
    ./gaming.nix
  ];
  home.packages = with pkgs; [
    pdfsam-basic
    zotero
    pkgs-unstable.zoom-us
    # gimp
    libreoffice
    onlyoffice-desktopeditors
    xournalpp
    rnote
    github-desktop
    miktex
    texstudio
    obsidian
    pwvucontrol
    wasistlos
  ];
}
