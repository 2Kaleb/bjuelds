{ pkgs, lib, ... }:
{
  imports = [
    ./common-cli.nix
  ];
  users.users.kdebre = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMR5MeTKnY2McxkQKmnLnVjAgkBFQC2XvOI+Sxb/UymV 2025"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH03/nW+q46o6KJub00y6Oyvu9mTAGJvQeczu/oRr5B+ u0_a256@localhost"
    ];
  };
  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  environment.systemPackages = with pkgs; [
    hugo
    anki
    copyparty
  ];

  nix.settings.trusted-users = [ "kdebre" ];

  services.caddy = {
    enable = true;
    virtualHosts."kalebdebre.de".extraConfig = ''
      root * /srv/website/public
      file_server 
    '';
    virtualHosts."tierlist.kalebdebre.de".extraConfig = ''
      root * /srv/tierlist
      file_server 
    '';
    virtualHosts."tailscale.kalebdebre.de".extraConfig = ''
      reverse_proxy localhost:8080
    '';
    virtualHosts."stepdaddy.kalebdebre.de".extraConfig = ''
      reverse_proxy localhost:3000
    '';
    virtualHosts."copyparty.kalebdebre.de".extraConfig = ''
      reverse_proxy localhost:3923 
    '';
    # virtualHosts."moodle.kalebdebre.de".extraConfig = ''
    #   reverse_proxy localhost:7070
    # '';
    virtualHosts."immich.kalebdebre.de".extraConfig = ''
      reverse_proxy localhost:2283
    '';
    virtualHosts."plausible.kalebdebre.de".extraConfig = ''
      reverse_proxy localhost:8000
    '';
    virtualHosts."pastebin.kalebdebre.de".extraConfig = ''
      reverse_proxy localhost:8088
    '';
    virtualHosts."anki.kalebdebre.de".extraConfig = ''
      reverse_proxy localhost:27701
    '';
    virtualHosts."vaultwarden.kalebdebre.de".extraConfig = ''
      reverse_proxy localhost:8222
    '';
    virtualHosts."searx.kalebdebre.de".extraConfig = ''
      reverse_proxy localhost:12345
    '';
  };

  services.copyparty = {
    enable = true;
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
      kdebre.passwordFile = "/home/kdebre/.secret-copyparty";
    };
    volumes = {
      "/" = {
        path = "/srv/public";
        access = {
          rwmd = [ "kdebre" ];
        };
      };
    };
  };
  # services.syncthing.enable = true;
  # services.fail2ban.enable = true;
  # services.pihole.enable = true;
  # services.nextcloud = {
  #   enable = true;
  #   hostName = "https://nextcloud.kalebdebre.de";
  #   config.dbtype = "sqlite";
  #   config.adminpassFile = "/home/kdebre/.nextcloud-adminpass";
  #   nginx.recommendedHttpHeaders = false;
  # };
  # services.anki-sync-server = {
  #   enable = true;
  #   openFirewall = true;
  #   port = 27701;
  #   users = [{
  #     username = "kdebre";
  #     passwordFile = ./.anki-password;
  #   }];
  # };

  # services.plausible = {
  #   enable = true;
  #   server.baseUrl = "https://plausible.kalebdebre.de";
  #   server.secretKeybaseFile = "/home/kdebre/.secret-plausible";
  # };
  services.vaultwarden = {
    enable = true;
  };
  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "server";
  };

  services.headscale = {
    enable = true;
    # user = "kdebre";
    address = "0.0.0.0";
    port = 8080;
    settings = {
      server_url = "https://tailscale.kalebdebre.de";
      dns.magic_dns = false;
      noise.private_key_path = "/var/lib/headscale/noise_private.key";
    };
  };

  services.wastebin = {
    enable = true;
    settings = {
      WASTEBIN_ADDRESS_PORT = "127.0.0.1:8088";
      WASTEBIN_BASE_URL = "https://pastebin.kalebdebre.de";
    };
  };

  services.searx = {
    enable = true;
    settings = {
      server.port = 12345;
      server.bind_address = "127.0.0.1";
      server.secret_key = "1901";
    };
  };

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

  networking = {
    hostName = "servitro";
    firewall.allowedTCPPorts = [
      80
      443
    ];

    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
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
              mountOptions = [
                "defaults"
              ];
            };
          };
        };
      };
    };
  };
  system.stateVersion = "24.11";

}
