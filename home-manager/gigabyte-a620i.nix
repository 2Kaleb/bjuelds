{ pkgs, ... }:

{
  imports =
    [ ./common-cli.nix ./common-gui.nix ./workstation.nix ./gaming.nix ];

  services.shikane.settings.profile = [
    {
      name = "asrock-b850i";
      output = [
        {
          enable = true;
          search = [ "m=XF240YU" ];
          mode = "2560x1440@143.856003Hz";
          position = "0,0";
          adaptive_sync = true;
        }
        {
          enable = true;
          search = [ "n=HDMI-A-2" ];
          position = "2560,0";
        }
      ];
    }
    {
      name = "gigabyte-a620i";
      output = [
        {
          enable = true;
          search = [ "m=H27T22C" ];
          mode = "2560x1440@180Hz";
          position = "0,0";
          adaptive_sync = true;
        }
        {
          enable = true;
          search = [ "n=HDMI-A-1" ];
          position = "2560,0";
        }
      ];
    }
  ];
}
