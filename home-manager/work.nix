{ pkgs, ... }: {
  home.packages = with pkgs; [ pdfsam-basic zotero zoom-us gimp libreoffice ];
}
