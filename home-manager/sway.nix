# Reference: https://github.com/wimpysworld/nix-config/blob/main/home-manager/_mixins/desktop/pantheon.nix

{ config, lib, pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "kitty"; 
      startup = [
        # Launch Firefox on start
        {command = "firefox";}
      ];
    };
  };
}

