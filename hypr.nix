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
      lightdm = {
        enable = true;
      };
    };
    windowManager.hypr = {
      enable = true;
    };
  };

  users.users.kraust = {
    packages = with pkgs; [
    ];
  };
}
