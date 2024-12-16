{ config, pkgs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "kdebre";
  home.homeDirectory = "/home/kdebre";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
  neovim
  fastfetch
  slurp
  grim
  tldr
  htop
  lazygit
  zoxide
  bat
  thunderbird
  nautilus
  curl
  unzip
  xorg.xauth
  zellij
  # docker
  foot
  floorp
  wofi
  # kanshi
  wl-clipboard
  # polkit_gnome
  # dunst
  distrobox
  amdvlk
  vulkan-tools
  vesktop
  pdfsam-basic

  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Kaleb Debre";
    userEmail = "kalebdebre@web.de";
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
  };


  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/.local/bin"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      # .. = "cd ..";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
