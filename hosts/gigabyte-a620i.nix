# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config,lib, pkgs, ... }:

{

  networking.hostName = "gigabyte-a620i"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.allowedUDPPorts = [ 4242];

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
      lan-mouse
  ];
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;


  environment.systemPackages = with pkgs; [
    lact
  lxqt.lxqt-policykit
  ];

  programs.virt-manager.enable=true;
  virtualisation.libvirtd = {
  enable = true;
  qemu = {
    package = pkgs.qemu_kvm;
    # runAsRoot = true;
    # swtpm.enable = true;
    # ovmf = {
    #   enable = true;
    #   packages = [(pkgs.OVMF.override {
    #     secureBoot = true;
    #     tpmSupport = true;
    #   }).fd];
    # };
  };
};
  xdg={
    portal={
      enable=true;
      # wlr.enable=true;
      extraPortals=[
        pkgs.xdg-desktop-portal-wlr
        pkgs.xdg-desktop-portal-gtk
        pkgs.gnome-keyring
      ];
      config={
        common = {
    default = [
      "gtk"
    ];
    "org.freedesktop.impl.portal.Secret" = [
      "gnome-keyring"
    ];
          "org.freedesktop.impl.portal.Screenshot"=[
            "wlr"
        ];
          "org.freedesktop.impl.portal.ScreenCast"=[
            "wlr"
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
  #   containers.enable=true;
    # podman.enable=true;
    # oci-containers.containers={
    # };

fonts.packages = with pkgs; [
    # nerdfonts
  nerd-fonts.jetbrains-mono
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
  programs.gnome-disks.enable=true;

  programs.steam = {
    enable = true;
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
      # protonup-qt doesnt't build
  ];
  };
  programs.gamemode.enable =true;
  #/usr/bin/gamescope -e -- /usr/bin/steam -tenfoot
  programs.gamescope={
  enable =true;
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
systemd.packages = with pkgs; [ lact ];
systemd.services.lactd.wantedBy = ["multi-user.target"];
programs.corectrl.enable=true;
  programs.kdeconnect.enable=true;
  programs.coolercontrol.enable=true;

  nix.settings.experimental-features = ["nix-command" "flakes"];



  # List services that you want to enable:
  services.seatd.enable=true;
  services.hardware.openrgb.enable=true;
  services.openssh.enable = true;
  security.pam.services.swaylock = {};
  security.polkit.enable=true;
  services.gvfs.enable=true;

  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
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

  #hardware-configuration.nix
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


  hardware={
    graphics.enable = true;
    amdgpu.initrd.enable=true;
    enableAllFirmware=true;
  cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  boot={
  kernelModules = [ "kvm-amd" ];
  extraModulePackages = [ ];
  supportedFilesystems = ["ntfs"]; 
  initrd.kernelModules = ["amdgpu" ];
  initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  loader={
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = null;
    };
    kernelParams = [
        "video=DP-1:2560x1440@143.856003"
        "video=HDMI-A-1:1920x1080@60"
        "amdgpu.ppfeaturemask=0xffffffff"
    ];
    # plymouth.enable=true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
