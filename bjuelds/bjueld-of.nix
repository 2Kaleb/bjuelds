{ pkgs, ... }:

{
  imports = [
    ./common-cli.nix
    ./common-gui.nix
  ];

  networking.hostName = "bjueld-of";

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };

  fileSystems."/boot" =
    { device = "/dev/nvme0n1p1";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
  fileSystems."/" =
    { device = "/dev/nvme0n1p2";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=root" ];
    };

  fileSystems."/home" =
    { device = "/dev/nvme0n1p2";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=home" ];
    };

  fileSystems."/nix" =
    { device = "/dev/nvme0n1p2";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=nix" "noatime"];
    };
  fileSystems."/swap"=
    { device = "/dev/nvme0n1p2";
      fsType = "btrfs";
options = ["noatime" "subvol=swap" ];
    };
  fileSystems."/home/kdebre/mnt/copyparty" = {
    device = "https://copyparty.kalebdebre.de";
    fsType = "davfs";
    options = [
      "user"
        "x-systemd.automount"
    ];
  };

  swapDevices = [
      { device="/swap/swapfile" ;
        size=4*1024;}
];

  # boot.kernelModules = [ "" ];
  # boot.initrd.availableKernelModules = [ "nvme" "ehci_pci" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
  system.stateVersion = "25.05";

	}
