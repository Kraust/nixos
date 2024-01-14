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
      defaultSession = "xfce";
    };
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };

  users.users.kraust = {
    packages = with pkgs; [
    ];
  };
}
