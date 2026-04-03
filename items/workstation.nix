{ pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./common-cli.nix
    ./common-gui.nix
  ];

  home.packages = with pkgs; [
    pdfsam-basic
    pkgs-unstable.zotero
    pkgs-unstable.zoom-us
    gimp
    libreoffice
    onlyoffice-desktopeditors
    xournalpp
    rnote
    # github-desktop
    # miktex
    # texstudio
    obsidian
    pympress
    typst
  ];

  # home.sessionVariables = {
  #   WLR_RENDERER = "vulkan";
  #   # MANGOHUD = 1;
  # };
  # wayland.windowManager.wayfire.settings = {
  #   "output:HDMI-A-1".icc_profile =
  #     /home/kdebre/.color/icc/sRGBColorSpaceProfile.icm;
  #   "output:HDMI-A-2".icc_profile =
  #     /home/kdebre/.color/icc/sRGBColorSpaceProfile.icm;
  # };
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
}
