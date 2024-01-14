{ config, pkgs, ... }:

{

  imports = [
    <nixos-hardware/raspberry-pi/4>
  ];

  # Set Hostname
  networking.hostName = "monster-girls";

  # Enable networking
  networking.networkmanager.enable = true;

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  # Docker
  virtualisation.docker.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # services.openssh.settings.PermitRootLogin = "yes";

  # Set the user up
  users.users.kraust = {
    isNormalUser = true;
    description = "Kraust";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      neovim
      neovim-qt
      firefox
      mpv
      hexchat
      fzf
      ripgrep
      neofetch
      stunnel
      pciutils
      usbutils
      htop
      obs-studio
      git
      filelight
      libreoffice-qt
      sshfs
      libraspberrypi
      raspberrypi-eeprom
      home-manager
    ];
  };

  # Enable raspberry pi 4 hardware settings.
  hardware = {
    raspberry-pi."4".audio.enable = false;
    raspberry-pi."4".fkms-3d.enable = true;
    deviceTree = {
      enable = true;
    };
  };
}
