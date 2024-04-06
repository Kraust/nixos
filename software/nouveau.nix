{ pkgs, config, libs, ... }:

{

  # Load nouveau driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nouveau"];

  # Blacklist nvidia
  boot.blacklistedKernelModules = [ "nvidia" "nvidia_uvm" "nvidia_drm" "nvidia_modeset" ];

  # Enable hardware acceleration for Nouveau
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      mesa
      mesa.drivers
    ];
  };
}
