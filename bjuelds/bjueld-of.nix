{ pkgs, ... }:

{
  imports = [ ./common-cli.nix ./common-gui.nix ];

  networking.hostName = "bjueld-of";

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    lact.enable = true;
    printing = {
      enable = true;
      drivers = with pkgs; [ cups-filters cups-browsed ];
    };
  };
  hardware.sane = {
    enable = true;
    extraBackends = with pkgs; [ sane-airscan ];
  };

  users.users."kdebre" = { extraGroups = [ "scanner" "lp" ]; };

  fileSystems = {
    "/boot" = {
      device = "/dev/nvme0n1p1";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
    "/" = {
      device = "/dev/nvme0n1p2";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=root" ];
    };

    "/home" = {
      device = "/dev/nvme0n1p2";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=home" ];
    };

    "/nix" = {
      device = "/dev/nvme0n1p2";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=nix" "noatime" ];
    };
    "/swap" = {
      device = "/dev/nvme0n1p2";
      fsType = "btrfs";
      options = [ "noatime" "subvol=swap" ];
    };
    "/home/kdebre/mnt/copyparty" = {
      device = "https://copyparty.kalebdebre.de";
      fsType = "davfs";
      options = [ "user" "noauto" ];
    };
  };

  swapDevices = [{
    device = "/swap/swapfile";
    size = 4 * 1024;
  }];

  networking.firewall.allowedTCPPorts = [
    3240 # USBip
  ];
  boot = {
    extraModulePackages = with pkgs.linuxPackages_latest; [ usbip ];
    kernelModules = [ "vhci_hcd" "usbip_host" ];
    initrd.availableKernelModules =
      [ "nvme" "ehci_pci" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
  };
  system.stateVersion = "25.05";

}
