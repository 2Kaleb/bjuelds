{ config, pkgs, pkgs-unstable, ... }: {
  home.username = "kdebre";
  home.homeDirectory = "/home/kdebre";

  home.packages = with pkgs; [ himalaya ];
  programs = {
    distrobox.enable = true;
    git = {
      enable = true;
      package = pkgs.gitMinimal;
      userName = "Kaleb Debre";
      userEmail = "kalebdebre@web.de";
      # ignoreFile = false;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      extraPackages = with pkgs; [
        nil
        nixfmt-rfc-style
        nodejs-slim
        cargo
        gcc
        gnumake
        ripgrep
        wget
        unzip
      ];
    };
    bat = {
      enable = true;
      config.style = "header";
    };
    fastfetch = {
      enable = true;
      package = pkgs-unstable.fastfetch;
      settings = {
        logo = { padding = { top = 2; }; };
        modules = [
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
          "terminalfont"
          "terminaltheme"
          {
            type = "cpu";
            showPeCoreCount = true;
            temp = true;
          }
          {
            type = "gpu";
            driverSpecific = true;
            temp = true;
          }
          "memory"
          "physicalmemory"
          "swap"
          "disk"
          {
            type = "physicaldisk";
            temp = true;
          }
          "battery"
          "localip"
          "break"
          "colors"
        ];
      };
    };
    htop = {
      enable = true;
      settings = {
        fields = with config.lib.htop.fields; [
          PID
          USER
          PERCENT_CPU
          M_RESIDENT
          STARTTIME
          ELAPSED
          COMM
        ];
        highlight_base_name = 1;
        color_scheme = 6;
        hide_userland_threads = 1;
        show_program_path = 0;
        show_cpu_frequency = 1;
        show_cpu_temperature = 1;
        sort_key = 39;
        sort_direction = -1;
      } // (with config.lib.htop;
        leftMeters [ (bar "CPU") (bar "AllCPUs2") (bar "MemorySwap") ])
        // (with config.lib.htop;
          rightMeters [
            (text "DateTime")
            (text "Hostname")
            (text "System")
            (text "Uptime")
            (text "DiskIO")
            (text "NetworkIO")
          ]);
    };
    lazygit.enable = true;
    tealdeer.enable = true;
    yazi.enable = true;
    zellij.enable = true;
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    fish = {
      enable = true;
      functions = {
        listpackages =
          "nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq";
        listapplications =
          "echo '/etc/profiles/per-user/kdebre/share:/run/current-system/sw/share' | tr ':' '\\n' | sort | uniq | xargs -I {} find {} -name '*.desktop'";
        listbinaries =
          "ls -1 /etc/profiles/per-user/kdebre/bin /run/current-system/sw/bin | sort | uniq";

      };
    };
  };

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
