{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:

{
  imports = [
    ./common-cli.nix
  ];
  environment.systemPackages = with pkgs; [
    intel-gpu-tools
    mkvtoolnix-cli
    fzf
    handbrake
    dufs
    smartmontools
  ];
  networking = {
    hostName = "htpc";
    firewall.allowedTCPPorts = [
      8901 # tuliprox
    ];
  };

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
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;
    }
  ];

  boot = {
    supportedFilesystems = [ "ntfs" ];
    kernelParams = [ "i915.enable_guc=2" ];
  };

  system.stateVersion = "24.05";

  users.groups.media = { };
  users.users.kdebre = {
    extraGroups = [ "media" ];
  };
  systemd.services.shoko.serviceConfig.SupplementaryGroups = "media";
  services = {
    shoko = {
      enable = true;
      package = pkgs-unstable.shoko;
      webui = pkgs-unstable.shoko-webui;
      openFirewall = true;
    };
    tuliprox = {
      enable = true;
      systemSettings = {
        api = {
          host = "100.64.0.15";
          port = 8901;
        };
        web_ui = {
          enabled = true;
        };
      };
      sourceSettings = {
        sources = [
          {
            inputs = [
              {
                name = "iptv-org-ethiopia";
                type = "m3u";
                url = "https://iptv-org.github.io/iptv/countries/et.m3u";
              }
              {
                name = "iptv-org-germany";
                type = "m3u";
                url = "https://iptv-org.github.io/iptv/countries/de.m3u";
              }
              {
                name = "iptv-org-sports";
                type = "m3u";
                url = "https://iptv-org.github.io/iptv/categories/sports.m3u";
              }
            ];
            # inputs = [
            #   "iptv-org-ethiopia"
            #   "iptv-org-germany"
            #   "iptv-org-sports"
            # ];

            targets = [
              {
                filter = "!all_channels!";
                name = "iptv-org";
                output = [
                  {
                    type = "xtream";
                  }
                ];
              }
            ];
          }
        ];
        templates = [
          {
            name = "all_channels";
            value = "Title ~ \".*\"";
          }
        ];
      };
      apiProxySettings = {
        server = [
          {
            host = "100.64.0.15";
            message = "Welcome to tuliprox";
            name = "default";
            port = 8901;
            protocol = "http";
            timezone = "Europe/Paris";
          }
          # {
          #   host = "tuliprox.mydomain.tv";
          #   message = "Welcome to tuliprox";
          #   name = "external";
          #   port = 443;
          #   protocol = "https";
          #   timezone = "Europe/Paris";
          # }
        ];
        user = [
          {
            credentials = [
              {
                # exp_date = 1672705545;
                # max_connections = 1;
                password = "secret1";
                proxy = "reverse";
                server = "default";
                # status = "Active";
                # token = "token1";
                username = "test1";
              }
            ];
            target = "iptv-org";
          }
        ];
      };
    };
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
      package = pkgs-unstable.jellyfin;
      group = "media";
      openFirewall = true;
    };
    jellyseerr = {
      enable = true;
      openFirewall = true;
    };
    audiobookshelf = {
      enable = true;
      host = "100.64.0.15";
      # port=8000;
      openFirewall = true;
      group = "media";
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
    readarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
    immich = {
      enable = true;
      group = "media";
      host = "100.64.0.15";
      openFirewall = true;
      machine-learning.enable = true;
      mediaLocation = "/srv/media/images";
      environment = {
        IMMICH_LOG_LEVEL = "verbose";
      };
    };
  };
}
