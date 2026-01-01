{ pkgs, solaar, ... }:
{
  hardware.amdgpu = {
    opencl.enable = true; # adds    pkgs.rocmPackages.clr pkgs.rocmPackages.clr.icd
    overdrive.enable = true;
  };
  environment.systemPackages = with pkgs; [ lact ];
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];
  programs.corectrl.enable = true;
  # services.hardware.openrgb.enable = true;
  services.sunshine = {
    enable = true;
    openFirewall = true;
    capSysAdmin = true;
    applications = {
      apps = [
        # {
        #   name = "Desktop";
        #   image-path = "desktop.png";
        # }
        {
          name = "1";
          detached = [
            # "setsid steam steam://open/bigpicture"
            "setsid steam steam://open/bigpicture" # -tenfoot"
          ];
          image-path = "steam.png";
        }
        {
          name = "2";
          detached = [
            # "setsid steam steam://open/bigpicture"
            "setsid steam ${pkgs.steam}/bin/steam -tenfoot"
          ];
          image-path = "steam.png";
        }
      ];
    };
  };

  # services.solaar.enable = true; # https://github.com/pwr-Solaar/Solaar
  services.ratbagd.enable = true;

  # programs.gamemode.enable = true;
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  #gamescope --hdr-enabled --expose-wayland --backend drm --rt -steam -W 1920 -H 1080 -r 60 --mangoapp --fullscreen -- steam -bigfoot
  programs.steam = {
    enable = true;
    protontricks.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      steamtinkerlaunch
    ];
    extraPackages = with pkgs; [
      gamescope
      protonplus
    ];
    package = pkgs.steam.override {
      extraEnv = {
        # MANGOHUD = true;
        # OBS_VKCAPTURE = true;
        # ENABLE_VKBASALT = true;
      };
    };
  };

}
