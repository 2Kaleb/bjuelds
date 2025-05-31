{ pkgs, ... }: {

  boot = {
    kernelParams = [
      # "video=DP-1:2560x1440@143.856003"
      # "video=HDMI-A-1:1920x1080@60"
      "amdgpu.ppfeaturemask=0xffffffff"
    ];
  };

  programs.steam = {
    enable = true;
    protontricks.enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin steamtinkerlaunch ];
    extraPackages = with pkgs; [ gamescope protonplus ];
    package = pkgs.steam.override {
      extraEnv = {
        MANGOHUD = true;
        OBS_VKCAPTURE = true;
        ENABLE_VKBASALT = true;
      };
    };
  };
  programs.gamemode.enable = true;
  #/usr/bin/gamescope -e -- /usr/bin/steam -tenfoot
  programs.gamescope = {
    enable = true;
    capSysNice = true;
    args = [
      "--expose-wayland"
      # "--rt"
      "--steam"
      # "--expose-wayland"
      # "-W 1920 -H 1080"
      # "-r 144"
      "--mangoapp"
      "--adaptive-sync"
      "-f"
    ];
  };

  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];
  programs.corectrl.enable = true;
  programs.coolercontrol.enable = true;
  services.hardware.openrgb.enable = true;
}
