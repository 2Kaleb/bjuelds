{ pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./common-cli.nix
    ./common-gui.nix
  ];
  home.packages = with pkgs; [
    rnote
    tiny # irc client
    streamlink
    pkgs-unstable.zotero
    bluetui
  ];

  services.shikane.settings.profile = [
    {
      name = "builtin";
      output = [
        {
          enable = true;
          search = [ "n=DSI-1" ];
          scale = 1.0;
          position = "0,0";
        }
      ];
    }
    {
      name = "builtin+external";
      output = [
        {
          enable = true;
          search = [ "n=DSI-1" ];
          scale = 1.0;
          # mode = "2560x1440@143.856003Hz";
          position = "0,0";
          # adaptive_sync = true;
        }
        {
          enable = true;
          search = [ "n=DP-1" ];
          position = "40,-1080";
          scale = 1.0;
        }
      ];
    }
  ];

  xdg.systemDirs.data= ["/home/kdebre/.nix-profile/share" "/home/kdebre/.local/share/flatpak/exports/share" "/var/lib/flatpak/exports/share"];
}
