{ pkgs, config, libs, ... }:

{

  # Enable OpenGL
  hardware.graphics.enable = true;

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "560.35.03";
      sha256_64bit = "sha256-8pMskvrdQ8WyNBvkU/xPc/CtcYXCa7ekP73oGuKfH+M=";
      sha256_aarch64 = "";
      openSha256 = "sha256-/32Zf0dKrofTmPZ3Ratw4vDM7B+OgpC4p7s+RHUjCrg=";
      settingsSha256 = "sha256-kQsvDgnxis9ANFmwIwB7HX5MkIAcpEEAHc8IBOLdXvk=";
      persistencedSha256 = "";
      # patches = [ rcu_patch ];
      patches = [ ];
    };

    open = true;
    nvidiaSettings = true;
    powerManagement = {
      enable = true;
      finegrained = true;
    };
    modesetting = {
      enable = true;
    };
    prime = {
      offload = {
        enable = true;
    	enableOffloadCmd = true;
      };
      amdgpuBusId = "PCI:10:0:1";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
