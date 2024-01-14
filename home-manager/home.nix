{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kraust";
  home.homeDirectory = "/home/kraust";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kraust/etc/profile.d/hm-session-vars.sh
  #

  home.enableNixpkgsReleaseCheck = false;

  programs = {
    home-manager.enable = true;
    bash = {
      enable = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  # temporary workaround
  manual.html.enable = false;
  manual.manpages.enable = false;
  manual.json.enable = false;


  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, N, exec, nvim-qt"
        "$mod, F, exec, firefox"
        "$mod, R, exec, hyprctl reload"
        "$mod SHIFT, left, movewindow, l"
        "$modSHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        "$mod, B, exec, pkill -SIGUSR1 waybar"
        "$mod, SPACE, exec, pkill wofi || wofi --show=drun"
        "$mod, Q, killactive"
      ];
      monitor = [
        "DP-2, 3840x2160, 0x0, 1"
        "DP-3, 3840x2160, 3840x0, 1"
      ];
      input = {
        sensitivity = 1.25;
        force_no_accel = true;
      };
      exec-once = [
        "waybar"
      ];
      windowrule = [
        "float,^(steam)$"
        "float,^(hexchat)$"
     ];
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.libsForQt5.breeze-gtk;
      name = "Breeze-Dark";
    };

    iconTheme = {
      package = pkgs.libsForQt5.breeze-gtk;
      name = "Breeze-Dark";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };
}
