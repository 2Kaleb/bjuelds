{ pkgs, pkgs-unstable, ... }:

{
  imports = [ ./common-cli.nix ./common-gui.nix ];

  services.shikane.settings.profile = [
    {
      name = "workstation";
      output = [
        {
          enable = true;
          search = [
            "n=HDMI-A-2"
            "m=EV2456"
          ]; # , v=Eizo Nanao Corporation, s=0x03B60B34";
          position = "0,0";
        }
        {
          enable = true;
          search = [
            "n=HDMI-A-1"
            "m=LEN LT2452pwC"
          ]; # , v=Lenovo Group Limited,  s=VN-669632";
          position = "1920,0";
        }
      ];
    }
    {
      name = "laptop";
      output = [
        {
          enable = true;
          search = "n=eDP-1";
          position = "0,0";
        }
        {
          enable = true;
          search = [ "n=HDMI-A-1" ];
          position = "900,-1080";
        }
      ];
    }
  ];

  home.packages = with pkgs; [
    pdfsam-basic
    zotero
    pkgs-unstable.zoom-us
    gimp
    libreoffice
    onlyoffice-desktopeditors
    xournalpp
    rnote
    github-desktop
    miktex
    texstudio
    obsidian
    pwvucontrol
    wasistlos
    pympress
  ];
}
