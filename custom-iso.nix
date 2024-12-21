
{config,pkgs,modulesPath, ... }:{

imports =[
"${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
];
nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
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
  users.users.nixos = {
    isNormalUser = true;
    description = "nixos";
    extraGroups = [ "wheel"];
    packages = with pkgs; [
  ];
  };

  environment.systemPackages = with pkgs; [
  neovim
  fastfetch
  tldr
  git  
  htop
  lazygit
  starship
  zoxide
  bat
  zellij
  foot
  floorp
  wofi
  wl-clipboard
  baobab
  gparted
  czkawka
  ];

fonts.packages = with pkgs; [
  (nerdfonts.override { fonts = [ "DroidSansMono" ]; })
];

environment.variables.EDITOR = "nvim";

#Helpful Reddit Comment
environment.etc."current-system-packages".text =
  let
    packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
    sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
    formatted = builtins.concatStringsSep "\n" sortedUnique;
  in
    formatted;

services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
  programs.wayfire={
  enable=true;
  plugins= with pkgs.wayfirePlugins;[
  wf-shell
  ];
  };

  hardware.opengl.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?

}
