{ config, pkgs, ... }:

let
  kernel = pkgs.linuxPackages_latest;
in
{

  imports = [
    ./users/kraust.nix
    ./software/nvidia.nix
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

  boot.extraModulePackages = with config.boot.kernelPackages; [
  ];

  boot.initrd.kernelModules = [
    "msr"
    "vfio"
    "vfio_iommu_type1"
    "vfio_pci"
  ];

  # Blacklist watchdog.
  boot.blacklistedKernelModules = [
  ];
  # options vfio-pci ids=1002:164e,1002:1640
  boot.extraModprobeConfig = ''
    options vfio-pci ids=1002:67df,1002:aaf0
  '';
  boot.kernelParams = [
    "amd_iommu=on"
    "nvidia_drm.fbdev=1"
  ];

  boot.tmp.useTmpfs = true;

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
    extraGroups = [ "networkmanager" "wheel" "docker" "wireshark" "tcpdump" "scanner" "lp" "gamemode" "libvirtd" ];
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

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };
  programs.virt-manager.enable = true;

  # Possibly fixes Network Manager + 5GHz issues?
  networking.networkmanager = {
    wifi = {
      scanRandMacAddress = false;
      powersave = false;
    };
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  programs.dconf.enable = true;

  security.polkit.enable = true;
  security.pam.loginLimits = [
    {
      domain = "@users";
      item = "rtprio";
      type = "-";
      value = 1;
    }
  ];

  services.gvfs = {
    enable = true;
  };

  powerManagement.cpuFreqGovernor = "powersave";

  virtualisation.spiceUSBRedirection.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    lm_sensors
    linuxPackages.turbostat
    gparted
  ];

  # Enable Desktop
  services.desktopManager = {
    cosmic.enable = true;
  };

  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "kraust";
    };
    cosmic-greeter.enable = true;
  };

}
