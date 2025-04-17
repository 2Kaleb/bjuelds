{ config, pkgs,pkgs-unstable, ... }:
{


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
  # zip unzip curl wget zig python3 cargo julia binutils
  slurp grim wl-clipboard
  nautilus
    vesktop 
    pdfsam-basic zotero
    pkgs-unstable.zoom-us
    whatsapp-for-linux gimp
  vulkan-tools libva-utils
  streamlink-twitch-gui-bin streamlink chatterino2
  rsshub
    vlc
    onlyoffice-desktopeditors libreoffice
  distrobox
  gparted baobab czkawka 
    xorg.xeyes
    networkmanagerapplet
qimgv
    thunderbird
    wlsunset wlogout wlr-randr
    pympress
    brightnessctl
    cifs-utils
  ];


  # basic configuration of git, please change to your own
  programs =
  {
    git = {
    enable = true;
    userName = "Kaleb Debre";
    userEmail = "kalebdebre@web.de";
    };
# thunderbird={
# enable=true;
#         profiles.kdebre={
#     settings={
#   "pdfjs.spreadModeOnLoad"=true;
#   "browser.bookmarks.openInTabClosesMenu"=false;
#    "browser.sessionstore.resume_from_crash"= false;
#   };
#       };
# };
      swaylock={
        enable=true;
        settings={
        image = "/etc/nixos/wayfire/wallpaper/windows10.jpg";
      };
      };
      neovim={
        enable=true;
        defaultEditor=true;
      };
      bat.enable=true;
      bottom.enable=true;
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
	"battery"
         "localip"
        "break"
        "colors"
    ];
    };
      };
      floorp={
        enable=true;
          # profiles.kdebre.settings={
          # "pdfjs.spreadModeOnLoad"=true;
          # "browser.bookmarks.openInTabClosesMenu"=false;
          #  "browser.sessionstore.resume_from_crash"= false;
          # };
      };

      wezterm.enable=true;
      kitty.enable=true;
      alacritty.enable=true;
      ghostty.enable=true;
      foot=  let
  foot-theme=pkgs.fetchurl{
    url=    "https://codeberg.org/dnkl/foot/raw/branch/master/themes/kitty";
    hash= "sha256-V0m8tmR4QFRWe//ltX++ojD5X+x2x3cRHaKWfnL8OH8=";
        };
    in        {
        enable=true;
        server.enable=false;
        settings={
      main={
          font="JetBrainsMonoNFM-Regular:size=14";
        include = "${foot-theme}";
          };
      colors.alpha=0.5;
    };
      };

      freetube.enable=true;
      fuzzel.enable=true;
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
          show_cpu_frequency=1;
          show_cpu_temperature=1;
          sort_key=39;
          sort_direction=-1;
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
        # enableSessionWide=true;
        settings={
            full = true;
      };
      };
      mpv.enable=true;
      sioyek={
      enable=true;
      package=pkgs-unstable.sioyek;
      };
      tealdeer.enable = true;
      yazi.enable = true;
      yt-dlp.enable = true;
      # zed-editor.enable = true;
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

  };

  services= {
    podman.enable=true;
    mako.enable=true;
    # kdeconnect.enable=true;
    # kanshi.enable=true;
    # glance.enable=true;
  # syncthing.enable=true;
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
