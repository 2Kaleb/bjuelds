{ config, pkgs,pkgs-unstable, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "kdebre";
  home.homeDirectory = "/home/kdebre";
  home.sessionPath = [
    # "$HOME/.local/bin"
  ];
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # link the configuration file in current directory to the specified location in home directory
home.file.".config/wayfire.ini".source = ./wayfire/wayfire.ini;
home.file.".config/wf-shell.ini".source = ./wayfire/wf-shell.ini;

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
  zip unzip curl wget zig 
  slurp grim wl-clipboard
  nautilus vesktop pdfsam-basic zotero onlyoffice-desktopeditors whatsapp-for-linux gimp
    thunderbird
    zoom-us
  vulkan-tools
  streamlink-twitch-gui-bin
  google-drive-ocamlfuse
  # vkbasalt
  # dolphin-emu
  # qemu_kvm
  # quickemu
  radeontop
  gparted baobab czkawka 
  strawberry
    xorg.xeyes
    pkgs-unstable.ghostty
  ];


  # basic configuration of git, please change to your own
  programs =
  {
    git = {
    enable = true;
    userName = "Kaleb Debre";
    userEmail = "kalebdebre@web.de";
    };
      wofi.enable=true;
      kitty.enable=true;
      alacritty.enable=true;
      neovim={
        enable=true;
        defaultEditor=true;
      };
      bat.enable=true;
      ripgrep.enable=true;
      bottom.enable=true;
      broot={
        enable=true;
        enableFishIntegration=true;
      };
      btop.enable=true;
      cava.enable=true;
      carapace={
        enable=true;
        enableFishIntegration=true;
      };
      eza.enable=true;
      fastfetch={
        enable=true;
        settings={
    logo= {
        padding= {
            top= 2;
        };
    };
    modules= [
        "title"
        "separator"
        "os"
        "host"
        "bios"
        "board"
        "kernel"
        "initsystem"
        "uptime"
        "processes"
        "packages"
        "shell"
        "display"
        "lm"
        "de"
        "wm"
        "terminal"
        {
            type= "cpu";
            showPeCoreCount= true;
            temp= true;
        }
        {
            type= "gpu";
            driverSpecific= true;
            temp= true;
        }
        "memory"
        "physicalmemory"
        "swap"
        "disk"
        {
            type= "physicaldisk";
            temp= true;
        }
         "localip"
        "break"
        "colors"
    ];
    };
      };
      floorp={
        enable=true;
      };
      foot={
        enable=true;
        settings={
      main.font="JetBrainsMonoNFM-Regular:size=10";
      colors.alpha=0.5;
        };
      };
      freetube.enable=true;
      fuzzel.enable=true;
      gitui.enable=true;
      gpg.enable = true;
      htop = {
        enable = true;
        settings={
      fields = with config.lib.htop.fields; [
          PID USER PERCENT_CPU M_RESIDENT STARTTIME ELAPSED COMM
          ];
          highlight_base_name=1;
          color_scheme=6;
          hide_userland_threads=1;
          show_program_path=0;
        }// (with config.lib.htop; leftMeters [
  (bar "CPU")
  (bar "AllCPUs2")
  (bar "MemorySwap")
]) // (with config.lib.htop; rightMeters [
  (text "DateTime")
  (text "Hostname")
  (text "System")
  (text "Uptime")
  (text "DiskIO")
  (text "NetworkIO")
]);
      };
      lazygit.enable = true;
      mangohud = {
        enable = true;
        enableSessionWide=true;
      };
      mcfly = {
        enable = true;
        enableFishIntegration=true;
      };
      mpv.enable=true;
      lsd={
      enable=true;
        enableAliases=true;
      };
      qutebrowser.enable=true;
      sioyek.enable=true;
      swaylock.enable=true;
      sagemath.enable=true;
      tealdeer.enable = true;
      # texlive={
      # enable = true;
      # packageSet=pkgs.texlive.combine.scheme-basic;
      # };
      # thunderbird = {
      #   enable = true;
      # };
      wezterm.enable = true;
      yazi = {
        enable = true;
        enableFishIntegration=true;
      };
      starship = {
        enable = true;
        enableFishIntegration=true;
      };
      yt-dlp.enable = true;
      zed-editor.enable = true;
      zellij.enable = true;
      zoxide = {
        enable = true;
        enableFishIntegration=true;
      };
      fish = {
        enable = true;
        shellAliases = {
          ".." = "cd ..";
          "ls-in" ="nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq";
        };
      };

  # obs-studio={
  # enable=true;
  # plugins= with pkgs.obs-studio-plugins; [
  # 	  wlrobs
  #  obs-vkcapture
  #  input-overlay
  #  obs-multi-rtmp
  #  advanced-scene-switcher
  #  obs-pipewire-audio-capture
  # ];
  # };


  };

  services= {
    podman.enable=true;
    network-manager-applet.enable=true;
    mako.enable=true;
    kdeconnect.enable=true;
    # kanshi.enable=true;
    # glance.enable=true;
  syncthing.enable=true;
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
