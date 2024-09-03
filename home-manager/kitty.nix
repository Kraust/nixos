{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
  };
}
