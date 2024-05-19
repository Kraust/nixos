# vim: set sw=2:

{ config, lib, pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/Pictures/walpapers/yuru-camp-s3-op-rin.jpg"
      ];
      wallpaper = [
        "DP-2,~/Pictures/walpapers/yuru-camp-s3-op-rin.jpg"
        "DP-3,~/Pictures/walpapers/yuru-camp-s3-op-rin.jpg"
      ];
    };
  };
}
