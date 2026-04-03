{ pkgs, ... }:

{
  imports = [
    ./common-cli.nix
    ./common-gui.nix
  ];

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      hplip
    ];
  };

  networking.hostName = "workstation";

  # Generates /etc/fstab
  fileSystems."/" = {
    device = "/dev/sda5";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/sda1";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };
  fileSystems."/home/kdebre/mnt/NTFS" = {
    device = "/dev/sda6";
    fsType = "ntfs3";
    options = [
      "x-systemd.automount"
      "uid=1000"
      "gid=100"
      "noauto"
    ];
  };

  fileSystems."/home/kdebre/mnt/nethome" = {
    device = "//venediger.nt.e-technik.tu-darmstadt.de/kd7bi";
    fsType = "cifs";
    options = [
      # "x-systemd.automount"
      "uid=1000"
      "gid=100"
      "credentials=/home/kdebre/.secrets-nethome"
    ];
  };

  fileSystems."/home/kdebre/mnt/qnap" = {
    device = "//st01.must.e-technik.tu-darmstadt.de/nts-group";
    fsType = "cifs";
    options = [
      "x-systemd.automount"
      "uid=1000"
      "gid=100"
      "credentials=/home/kdebre/.secrets-qnap"
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

  fileSystems."/home/kdebre/mnt/hessenbox" = {
    device = "https://next.hessenbox.de/remote.php/dav/files/kt91koru%40tu-darmstadt.de";
    fsType = "davfs";
    options = [
      "user"
      "x-systemd.automount"
    ];
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4 * 1024;
    }
  ];

  boot = {
    supportedFilesystems = [ "ntfs" ];
  };

  system.stateVersion = "24.11";

}
