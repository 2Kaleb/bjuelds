{ pkgs, ... }:

{
  imports = [
    ./common-cli.nix
    ./common-gui.nix
    ./gaming.nix
  ];
  environment.systemPackages = with pkgs; [
    # davinci-resolve
    clinfo
  ];
  # environment.variables = {
  #   RUSTICL_ENABLE = "radeonsi";
  # };
  networking = {
    hostName = "gigabyte-a620i";
  };
  networking.interfaces."enp8s0".wakeOnLan.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu.package = pkgs.qemu_kvm;
  };
  users.users.kdebre.extraGroups = [ "libvirtd" ];

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
  fileSystems."/home/kdebre/mnt/Games" = {
    device = "/dev/nvme0n1p6";
    fsType = "btrfs";
    options = [
      "subvol=Games"
    ];
  };

  fileSystems."/home/kdebre/mnt/Data" = {
    device = "/dev/nvme0n1p6";
    fsType = "btrfs";
    options = [
      "x-systemd.automount"
      "subvol=Data"
    ];
  };

  fileSystems."/home/kdebre/mnt/NTFS" = {
    device = "/dev/nvme0n1p7";
    fsType = "ntfs3";
    options = [
      "x-systemd.automount"
    ];
  };

  fileSystems."/home/kdebre/mnt/copyparty" = {
    device = "https://copyparty.kalebdebre.de";
    fsType = "davfs";
    options = [
      "user"
      "x-systemd.automount"
    ];
  };

  boot = {
    kernelModules = [ "kvm-amd" ];
    supportedFilesystems = [ "ntfs" ];
  };

  system.stateVersion = "24.05";

}
