# vim: set sw=2:

{ config, lib, pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/Pictures/walpapers/0x2wrv20qq7d1.png"
      ];
      wallpaper = [
        "DP-2,~/Pictures/walpapers/0x2wrv20qq7d1.png"
        "DP-3,~/Pictures/walpapers/0x2wrv20qq7d1.png"
      ];
    };
  };
}
