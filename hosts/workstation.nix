{ pkgs, pkgs-unstable, ... }:

{
  imports = [ ./common-cli.nix ./common-gui.nix ];
  environment.systemPackages = with pkgs; [ obs-studio ];
  # programs.zoom-us = {
  #   enable = true;
  #   package = pkgs-unstable.zoom-us;
  # };
  services.printing = {
    enable = true;
    drivers = with pkgs; [ gutenprint gutenprintBin hplipWithPlugin ];
  };
  services.solaar.enable = true;
  services.ratbagd.enable = true;

  networking.hostName = "workstation";

  fileSystems."/" = {
    device = "/dev/sda5";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/sda1";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };
  fileSystems."/mnt/ntfs" = {
    device = "/dev/sda6";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=1000" ];
  };
  fileSystems."/mnt/nethome" = {
    device = "//venediger.nt.e-technik.tu-darmstadt.de/kd7bi";
    fsType = "cifs";
    options = let
      automount_opts =
        "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in [
      "uid=kdebre,gid=users,noserverino,_netdev,${automount_opts},credentials=/home/kdebre/.secrets-nethome,file_mode=0644"
    ];
  };

  fileSystems."/mnt/qnap" = {
    device = "//st01.must.e-technik.tu-darmstadt.de/nts-group";
    fsType = "cifs";
    options = let
      automount_opts =
        "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in [
      "uid=kdebre,gid=users,noserverino,_netdev,${automount_opts},credentials=/home/kdebre/.secrets-qnap,file_mode=0644"
    ];
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024;
  }];

  boot = {
    kernelModules = [ "kvm-amd" ];
    supportedFilesystems = [ "ntfs" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = null;
    };
    kernelParams = [ ];
  };

  system.stateVersion = "24.11";

}
