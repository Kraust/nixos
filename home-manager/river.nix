{ pkgs, ... }:
{
  wayland.windowManager.river = {
    enable = true;
    systemd.enable = true;
    settings = {
      map = {
        normal = {
          "Super Q" = "close";
          "Super F" = "toggle-fullscreen";
          "Super Space" = "spawn 'rofi -show drun'";
          "Super Left" = "snap left";
          "Super Right" = "snap right";
          "Super Up" = "snap up";
          "Super Down" = "snap down";
        };
      };
      map-pointer = {
        normal = {
          "Super BTN_LEFT" = "move-view";
          "Super BTN_RIGHT" = "resize-view";
          "Super BTN_MIDDLE" = "toggle-float";
        };
      };
    };
  };

  home.packages = with pkgs; [
    xdg-desktop-portal-wlr
    slurp
    wl-clipboard
    wl-clipboard-x11
  ];

  services.mako = {
    enable = true;
    defaultTimeout = 60000;
  };
}
