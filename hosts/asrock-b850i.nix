{ ... }:

{
  imports = [ ./common-cli.nix ./common-gui.nix ./gaming.nix ];

  networking.hostName = "asrock-b850i";

  fileSystems."/" = {
    device = "/dev/nvme0n1p3";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/nvme0n1p5";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };
  fileSystems."/mnt/shared" = {
    device = "/dev/nvme0n1p4";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=1000" ];
  };

  boot.kernelModules = [ "kvm-amd" ];
  boot = {
    supportedFilesystems = [ "ntfs" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = null;
    };
  };

  system.stateVersion = "25.05";

}
