{ ... }:

{
  imports = [ ./common-cli.nix ./common-gui.nix ];
  home.file.".ssh" = {
    source = ~/.ssh;
    recursive = true;
  };
  home.file.".wallpaper".source = ../wallpaper;
}
