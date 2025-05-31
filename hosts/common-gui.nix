{ pkgs, ... }: {

  networking.networkmanager.enable = true;
  networking.wireless.enable = false;

  hardware = {
    graphics.enable = true;
    amdgpu.initrd.enable = true;
  };
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu.package = pkgs.qemu_kvm;
  };

  xdg.terminal-exec = {
    enable = true;
    settings.default = [ "foot.desktop" ];
  };

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      wayfire = {
        prettyName = "Wayfire";
        comment = "Wayfire compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/wayfire";
      };
    };
  };

  programs.kdeconnect.enable = true;
  programs.gnome-disks.enable = true;

  services.seatd.enable = true;

  security.pam.services.swaylock = { };
  services.gvfs.enable = true;

  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
  };
}
