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
    windowManager.fluxbox.enable = true;
  };

  users.users.kraust = {
    packages = with pkgs; [
    ];
  };
}
