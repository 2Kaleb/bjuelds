{ pkgs, ... }: {

  home.packages = with pkgs; [
    streamlink-twitch-gui-bin
    streamlink
    chatterino2
    vlc
    furmark
    unigine-superposition
    geekbench
  ];

  programs = {
    lutris.enable = true;
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
