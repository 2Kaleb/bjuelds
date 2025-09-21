{ pkgs, pkgs-unstable, ... }:

{
  imports = [ ./common-cli.nix ./common-gui.nix ./gaming.nix ];
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
      categories = [ "AudioVideo" "Recorder" ];
      # startupNotify = true;
      # startupWMClass = "obs";
    };
  };
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
    ashpd-demo
    door-knocker
    obsidian
    pwvucontrol
    wasistlos
    gnome-font-viewer
    element-desktop
  ];
}
