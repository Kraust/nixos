{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    displayManager = {
      autoLogin = {
        enable = true;
        user = "kraust";
      };
      gdm = {
        enable = true;
        wayland = true;
      };
    };
  };

  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # Whether to enable XWayland
    xwayland.enable = true;

    # Optional
    # Whether to enable patching wlroots for better Nvidia support
    enableNvidiaPatches = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  users.users.kraust = {
    packages = with pkgs; [
      wayland
      waybar
      wofi
      killall
    ];
  };

  # powerManagement.cpuFreqGovernor = "ondemand";
}
