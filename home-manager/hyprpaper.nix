# vim: set sw=2:

{ config, lib, pkgs, ... }:

let 
  wallpaper = "~/Pictures/walpapers/1690495032174264.jpg";
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        wallpaper
      ];
      wallpaper = [
        "DP-2,${wallpaper}"
        "DP-3,${wallpaper}"
      ];
    };
  };
}
