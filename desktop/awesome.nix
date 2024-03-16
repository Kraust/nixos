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
      sddm = {
        enable = true;
      };
      defaultSession = "none+awesome";
    };
    windowManager.awesome = {
      enable = true;
    };
  };
}
