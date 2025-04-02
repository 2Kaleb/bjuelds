# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config,lib, pkgs, ... }:

{
  # imports =
  #   [ # Include the results of the hardware scan.
  #     ./hardware-configuration.nix
  #   ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = null;
  # boot.plymouth={
  #   enable= true;
  #   theme = "breeze";
  # };
# Enable "Silent Boot"
  boot={
  #   consoleLogLevel = 0;
  #   initrd.verbose = false;
    kernelParams = [
        "video=DP-1:2560x1440@143.856003"
  "video=HDMI-A-1:1920x1080@60"
  #     "quiet"
  #     "splash"
  #     "boot.shell_on_fail"
  #     "loglevel=3"
  #     "rd.systemd.show_status=false"
  #     "rd.udev.log_level=3"
  #     "udev.log_priority=3"
    ];
  };

  networking.hostName = "gigabyte-a620i"; # Define your hostname.

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
    oci-containers.containers={
    };
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  environment.systemPackages = with pkgs; [
  # xorg.xauth
    lact
    nixos-icons
    davinci-resolve
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
    enable32Bit=true;
  extraPackages = with pkgs;[
  # amdvlk < radv
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
  services.seatd.enable=true;

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

services ={
sonarr = {
  enable = true;
  openFirewall = true;
    user="kdebre";
    group="users";
};
bazarr = {
  enable = true;
  openFirewall = true;
    user="kdebre";
    group="users";
};
lidarr = {
  enable = true;
  openFirewall = true;
    user="kdebre";
    group="users";
};
prowlarr = {
  enable = true;
  openFirewall = true;
};
radarr = {
  enable = true;
  openFirewall = true;
    user="kdebre";
    group="users";
};
readarr = {
  enable = true;
  openFirewall = true;
    user="kdebre";
    group="users";
};
jellyfin = {
  enable = true;
  openFirewall = true;
    user="kdebre";
    group="users";
};
jellyseerr = {
  enable = true;
  openFirewall = true;
};
sabnzbd = {
  enable = true;
  openFirewall = true;
    user="kdebre";
    group="users";
};
};

 # services.invidious.enable=true;
 services.seatd.enable=true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [22];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  #hardware-configuration.nix
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = ["amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = ["ntfs"]; 
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/68af7dc9-4720-4415-b887-7dac8569098e";
      fsType = "ext4";
    };
  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/A330-3A4C";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  fileSystems."/mnt/shared" =
    { device = "/dev/disk/by-uuid/6F2C1A2F1CE36C91";
      fsType = "ntfs-3g";
      options=[ "rw" "uid=1000"];
    };
  networking.useDHCP = lib.mkDefault true;
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
