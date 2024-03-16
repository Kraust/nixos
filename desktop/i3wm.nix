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
    windowManager.i3.enable = true;
  };

  users.users.kraust = {
    packages = with pkgs; [
      polybar
    ];
  };
}
