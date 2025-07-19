{ pkgs, pkgs-unstable, ... }:

{
  import = [
    ./common-cli.nix
    ./common-gui.nix
    ./servarr.nix
    ./gaming.nix
    ./webdav.nix
  ];
  environment.systemPackages = with pkgs; [
    davinici-resolve
    universal-android-debloater
  ];
  programs.adb.enable = true;
  networking.hostName = "gigabyte-a620i";

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/68af7dc9-4720-4415-b887-7dac8569098e";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/A330-3A4C";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };
  fileSystems."/mnt/shared" = {
    device = "/dev/disk/by-uuid/6F2C1A2F1CE36C91";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=1000" ];
  };

  boot = {
    kernelModules = [ "kvm-amd" ];
    supportedFilesystems = [ "ntfs" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = null;
    };
    kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];
  };

  system.stateVersion = "24.05";

}
