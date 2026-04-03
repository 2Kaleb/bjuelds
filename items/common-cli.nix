{
  config,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.username = "kdebre";
  home.homeDirectory = "/home/kdebre";
  home.packages = with pkgs; [
    himalaya
    isd
    ncdu
    # dua
    # duf
    # gdu
    # dust
    clock-rs
    wego
  ];
  accounts.email.accounts."tu-darmstadt.de" = {
    primary = true;
    address = "kaleb.debre@tu-darmstadt.de";
    realName = "Kaleb Debre";
    userName = "kt91koru";
    imap = {
      host = "mail.tu-darmstadt.de";
      port = 993;
      tls.enable = true;
    };
    smtp = {
      host = "smtp.tu-darmstadt.de";
      port = 465;
      tls.enable = true;
    };
    # signature.command = /home/kdebre/repos/dotfiles/Signatur_Arbeit.html;
    thunderbird.enable = true;
    himalaya.enable = true;
    himalaya.settings = {
      default = true;
      email = "kaleb.debre@tu-darmstadt.de";
      display-name = "Kaleb Debre";

      backend.type = "imap";
      backend.host = "mail.tu-darmstadt.de";
      backend.port = 993;
      backend.login = "kt91koru";
      backend.encryption.type = "tls";
      backend.auth.type = "password";
      backend.auth.keyring = "tu-darmstadt";

      message.send.backend.type = "smtp";
      message.send.backend.host = "smtp.tu-darmstadt.de";
      message.send.backend.port = 465;
      message.send.backend.login = "kt91koru";
      message.send.backend.encryption.type = "tls";
      message.send.backend.auth.type = "password";
      message.send.backend.auth.keyring = "tu-darmstadt";
    };
  };

  programs = {
    distrobox.enable = true;
    # himalaya.enable = true;
    git = {
      enable = true;
      package = pkgs.gitMinimal;
      settings = {
        pull.rebase = true;
        user = {
          email = "kalebdebre@web.de";
          name = "Kaleb Debre";
        };
      };
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      extraPackages = with pkgs; [
        nil
        nixfmt
        lua-language-server
        stylua
        nodejs-slim
        ripgrep
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
        logo = {
          padding = {
            top = 2;
          };
        };
        modules = [
          "title"
          "separator"
          "os"
          "host"
          "bios"
          "board"
          "kernel"
          "uptime"
          "packages"
          "shell"
          "display"
          "lm"
          "de"
          "wm"
          "cursor"
          "terminal"
          "terminalfont"
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
      }
      // (
        with config.lib.htop;
        leftMeters [
          (bar "CPU")
          (bar "AllCPUs2")
          (bar "MemorySwap")
        ]
      )
      // (
        with config.lib.htop;
        rightMeters [
          (text "DateTime")
          (text "Hostname")
          (text "System")
          (text "Uptime")
          (text "DiskIO")
          (text "NetworkIO")
        ]
      );
    };
    lazygit.enable = true;
    tealdeer.enable = true;
    yazi.enable = true;
    zellij.enable = true;
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    eza.enable = true;
    fish = {
      enable = true;
      shellAliases = {
        ls = "eza -lg";
        ll = "eza -lgTa -s modified";
      };
      functions = {
        listpackages = "nix-store --query --requisites /run/current-system";
        listapplications = "echo '/etc/profiles/per-user/kdebre/share:/run/current-system/sw/share' | tr ':' '\\n' | sort | uniq | xargs -I {} find {} -name '*.desktop'";
        listbinaries = "ls -1 /etc/profiles/per-user/kdebre/bin /run/current-system/sw/bin | sort | uniq";

      };
    };
  };

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
