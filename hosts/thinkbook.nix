# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config,lib, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = null;
  # boot.plymouth={
  #   enable= true;
  #   theme = "bgrt";
  # };
  networking.hostName = "thinkbook"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kdebre = {
    isNormalUser = true;
    description = "kdebre";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "seat"];
    packages = with pkgs; [
  ];
  };
  virtualisation ={
    containers.enable=true;
    podman.enable=true;
    oci-containers.containers={};
    libvirtd={
    enable=true;
     qemu.package = pkgs.qemu_kvm;
    };
  };

  xdg={
    portal={
      enable=true;
      # wlr.enable=true;
      # extraPortals=[
      #   "xdg-desktop-portal-wlr"
      #   "xdg-desktop-portal-gtk"
      #   "xdg-desktop-portal-kde"
      # ];
      config={
        common = {
    default = [
      "gtk"
    ];
    "org.freedesktop.impl.portal.Secret" = [
      "gnome-keyring"
    ];
          "org.freedesktop.portal.Screenshot"=[
            "wlr"
        ];
          "org.freedesktop.portal.ScreenCast"=[
            "wlr"
        ];
          "org.freedesktop.portal.InputCapture"=[
            "kde"
        ];
  };
      };
    };
    terminal-exec={
    enable=true;
    settings={
      default=[
        "foot.desktop"
    ];
    };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];


  environment.systemPackages = with pkgs; [
  ];

fonts.packages = with pkgs; [
    # nerdfonts
  (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
];

  # environment.variables.EDITOR = "nvim";
  programs.wayfire={
  enable=true;
  plugins= with pkgs.wayfirePlugins;[
  wf-shell
      wcm
  ];
  };
  programs.fish.enable = true;
  programs.virt-manager.enable = true;

  hardware.graphics={
  enable = true;
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.gnome-disks.enable=true;
  # List services that you want to enable:
  services.seatd.enable=true;

  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
  };
  services.printing.enable=true;
#   services.avahi = {
#   enable = true;
#   nssmdns4 = true;
#   openFirewall = true;
# };
  hardware.printers = {
  ensureDefaultPrinter = "nts-hp477mfp";
  ensurePrinters = [
    {
      name = "nts-hp477mfp";
      deviceUri = "socket://oistra.nt.e-technik.tu-darmstadt.de:9100";
      model = "drv:///sample.drv/laserjet.ppd";
    }
    {
      name = "nts-mfc8880";
      deviceUri = "socket://planja.nt.e-technik.tu-darmstadt.de:9100";
      model = "drv:///sample.drv/generic.ppd";
    }
  ];
};


  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  security.pam.services.swaylock = {};
services.gvfs.enable=true;
  services.gnome.gnome-keyring.enable=true;
  programs.seahorse.enable=true;


  #hardware-configuration.nix

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = ["ntfs"]; 

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a3a9848a-97a0-4c38-a2ae-8f73b35e7b02";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/1F2C-DA8C";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/mnt/shared" =
    { device = "/dev/disk/by-uuid/77FE099F69EF800A";
      fsType = "ntfs-3g";
      options=[ "rw" "uid=1000" "gid=100"];
    };
  fileSystems."/mnt/nethome" = {
    device = "//venediger.nt.e-technik.tu-darmstadt.de/kd7bi";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
