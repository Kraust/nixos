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
    };
    windowManager.spectrwm.enable = true;
  };

  users.users.kraust = {
    packages = with pkgs; [
      dmenu
    ];
  };
}
