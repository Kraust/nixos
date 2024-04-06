# vim: set sw=2:

{ config, pkgs, ... }:

{

  imports = [
    <home-manager/nixos>
    ../software/nvidia.nix
    #./software/nouveau.nix
  ];

  # Use rt kernel.
  boot.kernelPackages = pkgs.linuxPackages_6_6;

  # Set Hostname
  networking.hostName = "tiny-stars";

  # Enable networking
  networking.networkmanager.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Wireless Configuration
  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtl8812au
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

  boot.tmp.useTmpfs=true;

  # OpenGL Config
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Xbox One Controller
  hardware.xone.enable = true;

  # Tablet
  hardware.opentabletdriver.enable = true;

  # Scanner
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.epkowa ];

  # Needed by scanner?
  # services.avahi.enable = true;
  # services.avahi.nssmdns64 = true;

  # Printing
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  # GIMP support
  # ln -s /run/current-system/sw/bin/xsane ~/.config/GIMP/2.10/plug-ins/xsane
  nixpkgs.config.packageOverrides = pkgs: {
    xsaneGimp = pkgs.xsane.override { gimpSupport = true; };
  };

  # Docker
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
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
    extraGroups = [ "networkmanager" "wheel" "docker" "wireshark" "tcpdump" "scanner" "lp" ];
    packages = with pkgs; [
      neovim
      neovim-qt

      firefox-bin
      hexchat
      fzf
      ripgrep
      neofetch
      stunnel
      pciutils
      usbutils
      obs-studio
      git
      sshfs
      remmina
      nodejs
      qbittorrent
      libreoffice-qt
      gimp

      # Python
      (python3.withPackages(ps: with ps; [
        python-lsp-server
        setuptools
        flake8
        python-lsp-black
        pyls-isort
      ]))

      # MPV
      (mpv.override {scripts = [mpvScripts.mpris];})
      yad
      ffmpeg
      kdialog
      mkvtoolnix
      imagemagick

      # Gaming
      steam
      mangohud
      lutris
      gamemode

      # lua
      lua
      lua-language-server

      # go
      go

      opentabletdriver

      home-manager
      xdg-desktop-portal
      virtualenv
      pre-commit
      protontricks
      protonup
      protonup-qt
      nvd
      nix-output-monitor
      btop
      hyprpaper
      chromium
      simple-scan
      steam-run

    (pkgs.writeShellScriptBin "nmu" ''
      export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
      exec nvim-qt "$@"
    '')
   ];
  };

  environment.sessionVariables = {
    STEAM_FORCE_DESKTOPUI_SCALING = "1";
    GDK_SCALE = "1";
    MUFFIN_NO_SHADOWS = "1";
    NIXOS_OZONE_WL = "1";
  };

  # This apparently allows you to add stuff to your LD_LIBRARY_PATH
  # https://nix.dev/guides/faq.html
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libgit2
    ];
  };

  # TODO: Create SystemD Services
  # https:/nixos.wiki/wiki/Extend_NixOS
}
