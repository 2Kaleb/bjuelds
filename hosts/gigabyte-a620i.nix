{ pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./common-cli.nix
    ./common-gui.nix
    ./gaming.nix
  ];
  environment.systemPackages = with pkgs; [
    # davinci-resolve
    # universal-android-debloater
  ];
  programs.adb.enable = true;
  networking = {
    hostName = "gigabyte-a620i";
  };
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu.package = pkgs.qemu_kvm;
  };

  fileSystems."/" = {
    device = "/dev/nvme0n1p5";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/nvme0n1p1";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };
  fileSystems."/home/kdebre/Games" = {
    device = "/dev/nvme0n1p6";
    fsType = "btrfs";
    options = [
      "subvol=Games"
    ];
  };

  boot = {
    kernelModules = [ "kvm-amd" ];
    supportedFilesystems = [ ];
    loader = {
      systemd-boot = {
        enable = true;
        # windows."11" = {
        #   title = "Windows 11";
        #   sortKey = "m_windows";
        #   efiDeviceHandle = "HD0b1";
        # };
        # edk2-uefi-shell.enable = true;
      };
      efi.canTouchEfiVariables = true;
      timeout = 30;
    };
  };

  system.stateVersion = "24.05";

}
