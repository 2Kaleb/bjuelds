{ config, pkgs, ... }:
{
  home.sessionPath = [
    # "$HOME/.local/bin"
  ];
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    # XDG_CURRENT_DESKTOP = "sway";
    # GTK_USE_PORTAL="1";
  };

home.file.".config/wayfire.ini".source = ../wayfire/wayfire.ini;
home.file.".config/wf-shell.ini".source = ../wayfire/wf-shell.ini;

  home.packages = with pkgs; [
  slurp grim wl-clipboard
  nautilus door-knocker
    pdfsam-basic zotero
    zoom-us
    whatsapp-for-linux gimp
  streamlink-twitch-gui-bin streamlink chatterino2
    vlc
    wlr-randr
  davinci-resolve
    libreoffice
    qimgv
    jellyfin-mpv-shim jellyfin-rpc jellyfin-media-player
    networkmanagerapplet
   baobab czkawka 
    xorg.xeyes
    furmark unigine-superposition geekbench
    mission-center
    thunderbird
  ];


  # basic configuration of git, please change to your own
  programs =
  {
      # thunderbird.enable=true;
      lutris.enable=true;
      vesktop.enable=true;
      obs-studio={
            enable=true;
            plugins= with pkgs.obs-studio-plugins; [
            wlrobs
             obs-vkcapture
             input-overlay
             obs-multi-rtmp
             advanced-scene-switcher
             obs-pipewire-audio-capture
             # obs-gstreamer
      ];
      };
      swaylock={
        enable=true;
        settings={
        image = "/etc/nixos/wayfire/wallpaper/nixos.png";
      };
      };
      floorp={
        enable=true;
      };
      fuzzel.enable=true;
      mangohud = {
        enable = true;
        settings={
            preset = 3;
      };
      };
      mpv.enable=true;
      sioyek={
      enable=true;
      };
      zed-editor.enable = true;
  };

  services= {
    mako.enable=true;
    kdeconnect.enable=true;
  # syncthing.enable=true;
  };
}
