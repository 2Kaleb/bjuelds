{ config, pkgs, modulesPath, ... }: {

  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ./common-cli.nix
    ./common-gui.nix
  ];
  networking.hostName = "der-geraet";
}
