{ config, pkgs, ... }:

{

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
  boot.extraModprobeConfig = ''
    options 8812au rtw_led_ctrl=0
  '';
  boot.kernelParams = [ "rcu_nocbs=0-15" ];

  boot.tmp.useTmpfs=true;

  # OpenGL Config
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Nvidia Driver Config
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Xbox One Controller
  hardware.xone.enable = true;

  # Tablet
  hardware.opentabletdriver.enable = true;

  # Docker
  virtualisation.docker.enable = true;

  # Set the user up
  users.users.kraust = {
    isNormalUser = true;
    description = "Kraust";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      neovim
      neovim-qt
      firefox-bin
      hexchat
      fzf
      slack
      ripgrep
      neofetch
      stunnel
      pciutils
      usbutils
      htop
      obs-studio
      git
      sshfs
      rdesktop
      nodejs
      qbittorrent
      inkscape
      cpu-x
      libreoffice-qt
      filelight
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
      mpv
      yad
      ffmpeg
      kdialog
      mkvtoolnix
      imagemagick

      # Gaming
      steam
      mangohud
      lutris
      winePackages.stable
      winetricks

      # lua
      lua
      lua-language-server

      # go
      go

      opentabletdriver

      (pkgs.callPackage /home/kraust/git/nixos/sto-cat.nix {})
    ];
  };
}
