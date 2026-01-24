{ pkgs, ... }:

{
  imports = [
    ./common-cli.nix
  ];
  environment.systemPackages = with pkgs; [
    intel-gpu-tools
    mkvtoolnix-cli
  ];
  networking.hostName = "mediaserver";
  services.tailscale.useRoutingFeatures = "server";

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      # intel-media-sdk # causes EOL error, or  vpl-gpu-rt for QSV
      intel-compute-runtime-legacy1 # intel-ocl?
      intel-media-driver
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-id/ata-INTENSO_FD07075B1E1200145487-part2";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-id/ata-INTENSO_FD07075B1E1200145487-part1";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };
  fileSystems."/srv/media" = {
    device = "/dev/disk/by-id/ata-ST4000DM004-2CV104_ZFN1QPHY";
    fsType = "btrfs";
    options = [
      "subvol=media"
      "compress=zstd:3"
    ];
  };

  boot = {
    supportedFilesystems = [ "ntfs" ];
    kernelParams = [ "i915.enable_guc=2" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 30;
    };
  };

  system.stateVersion = "24.05";

  networking.firewall.allowedUDPPorts = [
    9000
    4556
  ];
  users.groups.media = { };
  users.users.kdebre = {
    extraGroups = [ "media" ];
  };
  services = {
    sonarr = {
      enable = true;
      group = "media";
      openFirewall = true;
    };
    radarr = {
      enable = true;
      group = "media";
      openFirewall = true;
    };
    sabnzbd = {
      enable = true;
      group = "media";
      openFirewall = true;
    };
    jellyfin = {
      enable = true;
      group = "media";
      openFirewall = true;
    };
    jellyseerr = {
      enable = true;
      openFirewall = true;
    };
    bazarr = {
      enable = true;
      group = "media";
      openFirewall = true;
    };
    lidarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
    readarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    immich = {
      enable = true;
      group = "media";
      openFirewall = true;
      mediaLocation = "/srv/media/images";
      environment = {
        IMMICH_LOG_LEVEL = "verbose";
      };
    };
  };
}
