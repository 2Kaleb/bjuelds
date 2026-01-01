{ pkgs, ... }:
{

  home.packages = with pkgs; [
    streamlink-twitch-gui-bin
    streamlink
    chatterino2
    piper
  ];

  programs = {
    lutris.enable = true;
  };
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vkcapture
      input-overlay
      advanced-scene-switcher
      obs-pipewire-audio-capture
      # obs-gstreamer
    ];
  };
  xdg.desktopEntries = {
    "com.obsproject.Studio" = {
      name = "OBS Studio";
      exec = "obs --disable-shutdown-check";
      icon = "com.obsproject.Studio";
      genericName = "Streaming/Recording Software";
      comment = "Free and Open Source Streaming/Recording Software";
      terminal = false;
      type = "Application";
      categories = [
        "AudioVideo"
        "Recorder"
      ];
      # startupNotify = true;
      # startupWMClass = "obs";
    };
  };
}
