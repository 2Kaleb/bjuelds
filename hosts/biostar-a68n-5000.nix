# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config,lib, pkgs, modulesPath, ... }:

{

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = null;
  # boot.plymouth={
  #   enable= true;
  #   theme = "breeze";
  # };
  # boot={
  #   consoleLogLevel = 0;
  #   initrd.verbose = false;
  #   kernelParams = [
  #     "quiet"
  #     "splash"
  #     "boot.shell_on_fail"
  #     "loglevel=3"
  #     "rd.systemd.show_status=false"
  #     "rd.udev.log_level=3"
  #     "udev.log_priority=3"
  #   ];
  # };

  networking.hostName = "biostar-a68n-5000"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

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
    extraGroups = [ "networkmanager" "wheel" "seat"];
    packages = with pkgs; [
  ];
  };
  virtualisation ={
    containers.enable=true;
    podman.enable=true;
    oci-containers.containers={
    };
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
  # xorg.xauth
    lact
    # lxqt.lxqt-policykit
  ];
systemd.packages = with pkgs; [ lact ];
systemd.services.lactd.wantedBy = ["multi-user.target"];

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

  hardware.graphics={
  enable = true;
  extraPackages = with pkgs;[
  ];
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.steam = {
    enable = false;
    protontricks.enable=true;
    package=pkgs.steam.override {
      extraEnv = {
        MANGOHUD = true;
        OBS_VKCAPTURE = true;
        ENABLE_VKBASALT = true;
      };
  };
  extraCompatPackages=with pkgs;[
      proton-ge-bin
        steamtinkerlaunch
  ];
  extraPackages=with pkgs;[
      gamescope
      # protonup-qt
  ];
  };
  programs.gamemode.enable =false;
  #/usr/bin/gamescope -e -- /usr/bin/steam -tenfoot
  programs.gamescope={
  enable =false;
  args=[
  "--rt"
  "--expose-wayland"
  "-W 1920 -H 1080"
  "-r 144"
  # "--mangoapp"
  "--adaptive-sync"
  "-f"
  ];
  };
  programs.gnome-disks.enable=true;
  # List services that you want to enable:

services.pipewire = {
    enable = true;
    # alsa.enable = true;
    # alsa.support32Bit = true;
    # pulse.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  security.pam.services.swaylock = {};
services.gvfs.enable=true;
  services.printing.enable=true;
  services.avahi = {
  enable = true;
  nssmdns4 = true;
  openFirewall = true;
};


  services.samba = {
    enable = true;
     openFirewall = true;
    settings = {
      global={
        "map to guest" = "bad user";
      };
      "public" = {
        "path" = "/mnt/public";
        "read only" = "yes";
        "browseable" = "yes";
        "guest ok" = "yes";
        "comment" = "Public samba share.";
      };
    };
  };
  #Whether to enable Web Services Dynamic Discovery host daemon. This enables (Samba) hosts, like your local NAS device, to be found by Web Service Discovery Clients like Windows .
  services.samba-wsdd = {
  enable = true;
  openFirewall = true;
};

# services ={
# sonarr = {
#   enable = true;
#   openFirewall = true;
# };
# bazarr = {
#   enable = true;
#   openFirewall = true;
# };
# lidarr = {
#   enable = true;
#   openFirewall = true;
# };
# prowlarr = {
#   enable = true;
#   openFirewall = true;
# };
# radarr = {
#   enable = true;
#   openFirewall = true;
# };
# readarr = {
#   enable = true;
#   openFirewall = true;
# };
# jellyfin = {
#   enable = true;
#   openFirewall = true;
# };
# jellyseerr = {
#   enable = true;
#   openFirewall = true;
# };
# sabnzbd = {
#   enable = true;
#   openFirewall = true;
# };
# };

 # services.invidious.enable=true;
 services.seatd.enable=true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [22];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;


  #hardware-configuration.nix
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "ohci_pci" "ehci_pci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelParams = [ "radeon.cik_support=0" "amdgpu.cik_support=1" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/638d8adf-f7b5-4e70-88b3-bf3831c59a8c";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7C08-6DB2";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

   swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 8*1024;
  } ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
