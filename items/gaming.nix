{ pkgs, ... }:
{

  home.packages = with pkgs; [
    # streamlink-twitch-gui-bin
    streamlink
    chatterino2
    piper
    moonlight-qt
    dolphin-emu
  ];

  programs = {
    mangohud = {
      enable = true;
      settings = {
        ## PERFORMANCE ##
        vulkan_present_mode = "mailbox";
        ## VISUAL ##
        gpu_stats = true;
        gpu_temp = true;
        cpu_stats = true;
        cpu_temp = true;
        fps = true;
        frametime = false;
        ### Display miscellaneous information
        engine_version = true;
        engine_short_names = true;
        gpu_name = true;
        vulkan_driver = true;
        wine = true;
        exec_name = true;
        winesync = true;
        present_mode = true;
        frame_timing = true;
        hud_no_margin = true;
        hud_compact = true;
        horizontal = true;
        ################ INTERACTION #################
        toggle_hud = "Shift_R+F12";
        toggle_hud_position = "Shift_R+F11";
        toggle_preset = "Shift_R+F10";
      };
    };
    lutris = {
      enable = true;
      winePackages = [
        pkgs.wineWow64Packages.wayland
      ];
    };
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        # wlrobs
        # obs-vkcapture
        # input-overlay
        advanced-scene-switcher
        obs-pipewire-audio-capture
        # obs-gstreamer
      ];
    };
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
