{ pkgs, ... }: {

  home.packages = with pkgs; [
    streamlink-twitch-gui-bin
    streamlink
    chatterino2
    vlc
    jellyfin-mpv-shim
    jellyfin-rpc
    jellyfin-media-player
    furmark
    unigine-superposition
    geekbench
    whatsapp-for-linux
  ];

  programs = {
    mangohud = {
      enable = true;
      settings = { preset = 3; };
    };
    lutris.enable = true;
    vesktop.enable = true;
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vkcapture
        input-overlay
        obs-multi-rtmp
        advanced-scene-switcher
        obs-pipewire-audio-capture
        # obs-gstreamer
      ];
    };
  };
}
