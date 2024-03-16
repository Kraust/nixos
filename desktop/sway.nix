{ config, pkgs, ... }:

{

  users.users.kraust = {
    packages = with pkgs; [
        alacritty
        dbus
        wayland
        xdg-utils
        glib
        dracula-theme
        gnome3.adwaita-icon-theme
        swaylock
        swayidle
        grim
        slurp
        wl-clipboard
        bemenu
        mako
        wdisplays
    ];
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  security.polkit.enable = true;
}
