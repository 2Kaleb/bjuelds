{
  pkgs,
  lib,
  pkgs-unstable,
  ...
}:
{
  imports = [
    ./common-cli.nix
  ];
  users.users.kdebre = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMR5MeTKnY2McxkQKmnLnVjAgkBFQC2XvOI+Sxb/UymV 2025"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH03/nW+q46o6KJub00y6Oyvu9mTAGJvQeczu/oRr5B+ u0_a256@localhost"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaRoWDLUQ6metfeLj5xHk4Q24Em+/v6WoyKwqJKirVr u0_a118@localhost"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ9Y7KCg1j193UzOQwX7d/vkF2pzKC2tbip2HEgyml++ kdebre@google-trogdor"
    ];
  };
  services.openssh.settings = {
    StreamLocalBindUnlink = true;
  };
  users.users.kdebre.extraGroups = [ "headscale" ];
  environment.systemPackages = with pkgs; [
    go
    hugo
    anki
    # copyparty
  ];

  nix.settings.trusted-users = [ "kdebre" ];

  # services.syncthing.enable = true;
  # services.fail2ban.enable = true;
  # services.nextcloud = {
  #   enable = true;
  #   hostName = "https://nextcloud.kalebdebre.de";
  #   config.dbtype = "sqlite";
  #   config.adminpassFile = "/home/kdebre/.nextcloud-adminpass";
  #   nginx.recommendedHttpHeaders = false;
  # };
  # services.moodle = {
  #   enable = true;
  #   initialPassword = "correcthorsebatterystaple";
  #   virtualHost = {
  #     hostName = "moodle.kalebdebre.de";
  #     listen = [{
  #       ip = "127.0.0.1";
  #       port = 7070;
  #       ssl = false;
  #     }];
  #   };
  # };
  services = {
    pihole-ftl.enable = true;
    pihole-web = {
      enable = true;
      ports = [ 2346 ];
    };
    gotify = {
      enable = true;
      environment = {
        GOTIFY_SERVER_PORT = 8001;
      };
    };
    plausible = {
      enable = false;
      server.baseUrl = "https://plausible.kalebdebre.de";
      server.secretKeybaseFile = "/home/kdebre/.secret-plausible";
    };
    copyparty = {
      enable = true;
      package = pkgs-unstable.copyparty-min; # -min
      user = "kdebre";
      settings = {
        i = "127.0.0.1";
        p = [ 3923 ];
        xff-hdr = "x-forwarded-for";
        xff-src = "127.0.0.1";
        rproxy = 1;
        allow-csrf = true;
        daw = true;
      };
      accounts = {
        kdebre.passwordFile = "/home/kdebre/.secret-copyparty-kdebre";
        Gast.passwordFile = "/home/kdebre/.secret-copyparty-Gast";
      };
      volumes = {
        "/" = {
          path = "/srv/public";
          access = {
            rwmd = [ "kdebre" ];
          };
        };
        "/Gast" = {
          path = "/srv/public/Gast";
          access = {
            rwmd = [ "Gast" ];
          };
        };
      };
    };
    anki-sync-server = {
      enable = false;
      openFirewall = false;
      port = 27701;
      users = [
        {
          username = "kdebre";
          passwordFile = ../.anki-password;
        }
      ];
    };
    uptime-kuma = {
      enable = true;
      settings = {
        HOST = "127.0.0.1";
        PORT = "3001";
      };
    };
    vaultwarden = {
      enable = true;
      config = {
        DOMAIN = "https://vaultwarden.kalebdebre.de";
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
        ROCKET_LOG = "critical";
      };
    };
    tailscale = {
      enable = true;
      openFirewall = true;
      useRoutingFeatures = lib.mkForce "server";
    };
    headscale = {
      enable = true;
      # user = "kdebre";
      # address = "127.0.0.1";
      # port = 443;
      settings = {
        server_url = "https://tailscale.kalebdebre.de";
        dns = {
          magic_dns = true;
          base_domain = "magicdns.ts.net";
          nameservers.global = [
            "9.9.9.9"
            "149.112.112.112"
          ];
          override_local_dns = true; # default
        };
        # noise.private_key_path = "/var/lib/headscale/noise_private.key";
      };
    };
    wastebin = {
      enable = true;
      settings = {
        WASTEBIN_ADDRESS_PORT = "127.0.0.1:8088";
        WASTEBIN_BASE_URL = "https://pastebin.kalebdebre.de";
      };
    };
    searx = {
      enable = true;
      settings = {
        server.port = 12345;
        server.bind_address = "127.0.0.1";
        server.secret_key = "1901";
      };
    };

    caddy = {
      # https://caddyserver.com/docs/caddyfile/directives/reverse_proxy#defaults
      enable = true;
      # virtualHosts."kalebdebre.de".extraConfig = ''
      #   root * /srv/website/public
      #   file_server
      # '';
      virtualHosts."kalebdebre.de".extraConfig = ''
        reverse_proxy localhost:1313
      '';
      virtualHosts."tierlist.kalebdebre.de".extraConfig = ''
        root * /srv/tierlist
        file_server
      '';
      virtualHosts."pihole.kalebdebre.de".extraConfig = ''
        reverse_proxy localhost:2346
      '';
      virtualHosts."tailscale.kalebdebre.de".extraConfig = ''
        reverse_proxy localhost:8080
      '';
      virtualHosts."copyparty.kalebdebre.de".extraConfig = ''
        reverse_proxy localhost:3923
      '';
      # virtualHosts."plausible.kalebdebre.de".extraConfig = ''
      #   reverse_proxy localhost:8000
      # '';
      virtualHosts."gotify.kalebdebre.de".extraConfig = ''
        reverse_proxy localhost:8001
      '';
      virtualHosts."pastebin.kalebdebre.de".extraConfig = ''
        reverse_proxy localhost:8088
      '';
      # virtualHosts."anki.kalebdebre.de".extraConfig = ''
      #   reverse_proxy localhost:27701
      # '';
      virtualHosts."vaultwarden.kalebdebre.de".extraConfig = ''
        reverse_proxy localhost:8222{
        header_up X-Real-IP {remote_host}
        }
      '';
      virtualHosts."searx.kalebdebre.de".extraConfig = ''
        reverse_proxy localhost:12345
      '';
      virtualHosts."uptime-kuma.kalebdebre.de".extraConfig = ''
        reverse_proxy localhost:3001
      '';
      virtualHosts."jellyfin.kalebdebre.de".extraConfig = ''
        reverse_proxy htpc:8096
      '';
      virtualHosts."sonarr.kalebdebre.de".extraConfig = ''
        reverse_proxy htpc:8989
      '';
      virtualHosts."radarr.kalebdebre.de".extraConfig = ''
        reverse_proxy htpc:7878
      '';
      virtualHosts."bazarr.kalebdebre.de".extraConfig = ''
        reverse_proxy htpc:6767
      '';
      virtualHosts."lidarr.kalebdebre.de".extraConfig = ''
        reverse_proxy htpc:8686
      '';
      virtualHosts."readarr.kalebdebre.de".extraConfig = ''
        reverse_proxy htpc:8787
      '';
      virtualHosts."prowlarr.kalebdebre.de".extraConfig = ''
        reverse_proxy htpc:9696
      '';
      virtualHosts."jellyseer.kalebdebre.de".extraConfig = ''
        reverse_proxy htpc:5055
      '';
      virtualHosts."sabnzbd.kalebdebre.de".extraConfig = ''
        reverse_proxy htpc:8080
      '';
      virtualHosts."audiobookshelf.kalebdebre.de".extraConfig = ''
        reverse_proxy htpc:8000
      '';
      virtualHosts."immich.kalebdebre.de".extraConfig = ''
        reverse_proxy htpc:2283
      '';
      virtualHosts."shoko.kalebdebre.de".extraConfig = ''
        reverse_proxy htpc:8111
      '';
      virtualHosts."tuliprox.kalebdebre.de".extraConfig = ''
        reverse_proxy htpc:8901
      '';
    };
  };

  networking = {
    hostName = "vps";
    firewall.allowedTCPPorts = [
      80
      443
      2346 # pihole
    ];

    nameservers = [
      "9.9.9.9"
      "149.112.112.112"
    ];
    interfaces.eth0 = {
      ipv4.addresses = [
        {
          address = "77.90.40.121";
          prefixLength = 24;
        }
      ];
      ipv6.addresses = [
        {
          address = "2a0f:85c1:b73:7d::a";
          prefixLength = 64;
        }
      ];
    };
    defaultGateway = {
      address = "77.90.40.1";
      interface = "eth0";
    };
    defaultGateway6 = {
      address = "2a0f:85c1:b73::1";
      interface = "eth0";
    };
  };

  #disk-config.nix
  disko.devices = {
    disk.disk1 = {
      device = lib.mkDefault "/dev/vda";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            name = "boot";
            size = "1M";
            type = "EF02";
          };
          esp = {
            name = "ESP";
            size = "500M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          root = {
            name = "root";
            size = "100%";
            content = {
              type = "lvm_pv";
              vg = "pool";
            };
          };
        };
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100%FREE";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [ "defaults" ];
            };
          };
        };
      };
    };
  };
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 2 * 1024;
    }
  ];
  boot.loader={
  lib.mkForce grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  };
  boot.initrd.availableKernelModules = [
    "ata_piix"
    "uhci_hcd"
    "virtio_pci"
    "virtio_scsi"
    "ahci"
    "sr_mod"
    "virtio_blk"
  ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];
  system.stateVersion = "24.11";

}
