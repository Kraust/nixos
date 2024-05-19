{ pkgs, config, libs, ... }:

{

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.powerManagement.enable = false;
  hardware.nvidia.powerManagement.finegrained = false;
  hardware.nvidia.open = false;
  hardware.nvidia.nvidiaSettings = true;

  hardware.nvidia.package = let 

  # wroots_screenshare_patch = pkgs.fetchpatch {
  #   url = "https://raw.githubusercontent.com/agoose77/nixos-config/76a9d77e80a6659f5876d56dd37f2b4183d13226/overlays/patches/nvidia.patch";
  #   hash = "sha256-SJJS/DCKCKPbTrFNx9vY+zzuV+X2tWQmjb2bgRXXrVU=";
  # };

  # rcu_patch = pkgs.fetchpatch {
  #   url = "https://github.com/gentoo/gentoo/raw/c64caf53/x11-drivers/nvidia-drivers/files/nvidia-drivers-470.223.02-gpl-pfn_valid.patch";
  #   hash = "sha256-eZiQQp2S/asE7MfGvfe6dA/kdCvek9SYa/FFGp24dVg=";
  # };

  # Nvida driver archive: https://www.nvidia.com/en-us/drivers/unix/linux-amd64-display-archive/
  # 550.54.14 cannot be used as it has a bug with wayland screen sharing and firefox.
  in config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "550.78";
    sha256_64bit = "sha256-NAcENFJ+ydV1SD5/EcoHjkZ+c/be/FQ2bs+9z+Sjv3M=";
    sha256_aarch64 = "";
    openSha256 = "sha256-wvRdHguGLxS0mR06P5Qi++pDJBCF8pJ8hr4T8O6TJIo=";
    settingsSha256 = "sha256-lZiNZw4dJw4DI/6CI0h0AHbreLm825jlufuK9EB08iw=";
    persistencedSha256 = "sha256-qDGBAcZEN/ueHqWO2Y6UhhXJiW5625Kzo1m/oJhvbj4=";
    # patches = [ rcu_patch ];
    patches = [];
 };
}
