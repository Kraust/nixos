# vim: set sw=2:

{ config, pkgs, ... }:

let
  kernel = pkgs.linuxPackages_6_8;
in
{

  imports = [
    <home-manager/nixos>
    <catppuccin/modules/nixos>
    ../users/kraust.nix
    ../software/nvidia.nix
  ];

  # Use rt kernel.
  boot.kernelPackages = kernel;

  # Set Hostname
  networking.hostName = "tiny-stars";

  # Enable networking
  networking.networkmanager.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # boot.extraModulePackages = with config.boot.kernelPackages; [
  # ];

  boot.extraModulePackages = [
    (config.boot.kernelPackages.callPackage ../software/rtl8812au.nix { })
  ];

  boot.initrd.kernelModules = [
    "8812au"
  ];

  # Blacklist watchdog.
  boot.blacklistedKernelModules = [
    "sp5100_tco"
  ];
  boot.extraModprobeConfig = ''
    options 8812au rtw_led_ctrl=0
  '';
  boot.kernelParams = [
  ];

  boot.tmp.useTmpfs = false;

  # OpenGL Config
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  # Xbox One Controller
  hardware.xone.enable = true;

  # Tablet
  hardware.opentabletdriver.enable = true;

  # Scanner
  # hardware.sane.enable = true;
  # hardware.sane.extraBackends = [ pkgs.epkowa ];

  # Needed by scanner?
  # services.avahi.enable = true;
  # services.avahi.nssmdns64 = true;

  # Printing
  # services.printing.enable = true;
  # services.avahi = {
  #   enable = true;
  #   nssmdns = true;
  #   openFirewall = true;
  # };

  # GIMP support
  # ln -s /run/current-system/sw/bin/xsane ~/.config/GIMP/2.10/plug-ins/xsane
  nixpkgs.config.packageOverrides = pkgs: {
    xsaneGimp = pkgs.xsane.override { gimpSupport = true; };
  };

  # Docker
  virtualisation.docker = {
    enable = true;
    # enableNvidia = true;
  };

  # OOM KIller
  services.earlyoom = {
    enable = true;
    freeSwapThreshold = 2;
    freeMemThreshold = 2;
  };

  # Testing
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      8083
    ];
    allowedUDPPortRanges = [
    ];
  };

  # Set the user up
  users.users.kraust = {
    isNormalUser = true;
    description = "Kraust";
    extraGroups = [ "networkmanager" "wheel" "docker" "wireshark" "tcpdump" "scanner" "lp" "gamemode" ];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;
  environment.sessionVariables = {
    STEAM_FORCE_DESKTOPUI_SCALING = "1";
    GDK_SCALE = "1";
    MUFFIN_NO_SHADOWS = "1";
    NIXOS_OZONE_WL = "1";
  };

  programs.wireshark.enable = true;

  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  programs.gamemode.enable = true;
  programs.gamemode.settings.general.inhibit_screensaver = 0;
}
