# Reference: https://github.com/wimpysworld/nix-config/blob/main/home-manager/_mixins/desktop/pantheon.nix

{ config, lib, pkgs, ... }:
with lib.hm.gvariant;
{
  dconf.settings = {
    "com/github/stsdc/monitor/settings" = {
      background-state = true;
      indicator-state = true;
      indicator-cpu-state = false;
      indicator-gpu-state = false;
      indicator-memory-state = false;
      indicator-network-download-state = true;
      indicator-network-upload-state = true;
      indicator-temperature-state = true;
    };

    "io/elementary/desktop/wingpanel" = {
      use-transparency = true;
    };

    "io/elementary/desktop/wingpanel/datetime" = {
      clock-format = "12h";
    };

    "io/elementary/desktop/wingpanel/sound" = {
      max-volume = 100.0;
    };

    "io/elementary/files/preferences" = {
      singleclick-select = false;
    };

    "io/elementary/notifications/applications/gala-other" = {
      remember = false;
      sounds = false;
    };

    "io/elementary/settings-daemon/datetime" = {
      show-weeks = true;
    };

    "io/elementary/settings-daemon/housekeeping" = {
      cleanup-downloads-folder = false;
    };

    "net/launchpad/plank/docks/dock1" = {
      alignment = "center";
      hide-mode = "window-dodge";
      icon-size = 48;
      pinned-only = false;
      position = "bottom";
      theme = "Transparent";
    };

    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };

    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      color-scheme = "prefer-dark";
      cursor-size = 32;
      cursor-theme = "elementary";
      document-font-name = "Work Sans 12";
      font-name = "Work Sans 12";
      gtk-theme = "io.elementary.stylesheet.bubblegum";
      gtk-enable-primary-paste = true;
      icon-theme = "elementary";
      monospace-font-name = "FiraCode Nerd Font Medium 13";
      text-scaling-factor = 1.0;
    };

    "org/gnome/desktop/session" = {
      idle-delay = lib.hm.gvariant.mkUint32 0;
    };

    "org/gnome/desktop/sound" = {
      theme-name = "elementary";
    };

    "org/gnome/desktop/wm/keybindings" = {
      # switch-to-workspace-left = [ "<Primary><Alt>Left" ];
      # switch-to-workspace-right = [ "<Primary><Alt>Right" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      audible-bell = false;
      button-layout = ":minimize,maximize,close";
      num-workspaces = 0;
      titlebar-font = "Work Sans Semi-Bold 12";
    };

    # These are custom keybindings.
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>e";
      command = "io.elementary.files -n ~/";
      name = "io.elementary.files -n ~/";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "interactive";
      sleep-inactive-ac-timeout = 0;
      sleep-inactive-ac-type = "nothing";
    };

    "org/gtk/gtk4/Settings/FileChooser" = {
      clock-format = "12h";
    };

    "org/gtk/Settings/FileChooser" = {
      clock-format = "12h";
    };

    "org/pantheon/desktop/gala/appearance" = {
      button-layout = ":minimize,maximize,close";
    };

    "org/pantheon/desktop/gala/behavior" = {
      dynamic-workspaces = false;
      overlay-action = "io.elementary.wingpanel --toggle-indicator=app-launcher";
    };

    "org/pantheon/desktop/gala/mask-corners" = {
      enable = false;
    };
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "elementary";
      package = pkgs.pantheon.elementary-icon-theme;
      size = 32;
    };

    font = {
      name = "Work Sans 12";
      package = pkgs.work-sans;
    };

    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      extraConfig = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    iconTheme = {
      name = "elementary";
      package = pkgs.pantheon.elementary-icon-theme;
    };

    theme = {
      name = "io.elementary.stylesheet.bubblegum";
      package = pkgs.pantheon.elementary-gtk-theme;
    };
  };

  home.pointerCursor = {
    package = pkgs.pantheon.elementary-icon-theme;
    name = "elementary";
    size = 16;
    gtk.enable = true;
    x11.enable = true;
  };
}

