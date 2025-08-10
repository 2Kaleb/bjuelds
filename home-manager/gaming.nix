{ pkgs, ... }: {

  home.packages = with pkgs; [
    streamlink-twitch-gui-bin
    streamlink
    chatterino2
  ];

  programs = { lutris.enable = true; };
}
