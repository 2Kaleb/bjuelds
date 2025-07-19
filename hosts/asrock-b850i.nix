{ pkgs, ... }:

{
  imports = [ ./common-cli.nix ./common-gui.nix ./gaming.nix ./webdav.nix ];

  networking.hostName = "asrock-b850i";
  # programs.fish = {
  # loginShellInit =  "gamescope --backend drm --steam --fullscreen -W 1920 -H 1080 -r 60 -- steam -tenfoot";
  # };

  environment.systemPackages = with pkgs; [ universal-android-debloater ];
  programs.adb.enable = true;
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
      systemd-boot = {
        enable = true;
        edk2-uefi-shell.enable = true;
        # windows."11" = {
        #   efiDeviceHandle = "HD0f";
        #   sortKey = "m_windows11";
        # };
      };
      efi.canTouchEfiVariables = true;
      timeout = null;
    };
  };

  system.stateVersion = "25.05";

}
