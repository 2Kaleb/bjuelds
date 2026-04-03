{ lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {
        enable = true;
        edk2-uefi-shell.enable = true;
      };
      efi.canTouchEfiVariables = true;
      timeout = 30;
    };
  };
  networking = {
    nftables.enable = true;
    networkmanager = {
      enable = true;
      plugins = with pkgs; [ networkmanager-openconnect ];
    };
  };
  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
    cpu.intel.updateMicrocode = true;
  };
  services.fwupd.enable = true;
  services.udisks2.enable = true;
  services.getty.autologinUser = lib.mkForce "kdebre";
  services.openssh = {
    enable = true;
    settings = { PasswordAuthentication = false; };
  };
  services.davfs2.enable = true;
  services.tailscale = {
    enable = true;
    openFirewall = true; # UDP 41641
    useRoutingFeatures = "client";
  };

  time.timeZone = "Europe/Berlin";

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

  console.keyMap = "de";
  users.users.kdebre = {
    isNormalUser = true;
    description = "kdebre";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "davfs2" ];
  };

  programs.fish.enable = true;
}
