{ config, lib, pkgs, ... }:

let
    opacity = "0.8";
in
{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {

    "$mod" = "SUPER";

    bind = [
      "$mod, left, movewindow, l"
      "$mod, right, movewindow, r"
      "$mod, up, movewindow, u"
      "$mod, down, movewindow, d"

      "$mod, Q, killactive"
      "$mod, F, togglefloating"
      "$mod, X, fullscreen"
      "$mod, F, resizeactive, exact 1920 1080"
      "$mod, R, exec, hyprctl reload"
      "$mod, V, exec, nmcli con up id CSPi --ask"
      "$mod, Space, exec, ulauncher"

      ", print, exec, grimshot savecopy area ~/Pictures/Screenshots/$(date +%Y%m%d%H%M%S).png"
      "$mod, print, exec, grimshot savecopy active ~/Pictures/Screenshots/$(date +%Y%m%d%H%M%S).png"
    ]
    ++ (
      # workspaces
      # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
      builtins.concatLists (builtins.genList
        (
          x:
          let
            ws =
              let
                c = (x + 1) / 10;
              in
              builtins.toString (x + 1 - (c * 10));
          in
          [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]
        )
        10)
    );

    bindel = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ];

    bindl = [
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioPlay, exec, playerctl --all-players play-pause"
    ];

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    monitor = [
      "DP-2, 3840x2160, 0x0, 1"
      "DP-3, 3840x2160, 3840x0, 1"
      "Unknown-1, disable"
    ];

    general = {
      border_size = "0";
      gaps_in = "0";
      gaps_out = "0";
    };

    decoration = {
      rounding = 0;
      drop_shadow = false;
      blur = {
        enabled = true;
        size = 10;
        passes = 3;
        new_optimizations = true;
        ignore_opacity = true;
        noise = 0;
        brightness = 0.90;
      };
    };

    animations = {
      enabled = true;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      initial_workspace_tracking = 2;
    };

    exec-once = [
      "mako"
      "glance -f  ~/.config/glance/glance.yml"
      "[workspace 1 silent] neovide -- -S ~/.config/nvim/sessions/home"
      "[workspace 3 silent] ~/bin/hpg10-2"
      "[workspace 10 silent] firefox"
    ];

    exec = [
      "dbus-sway-environment"
      "configure-gtk"
    ];

    windowrulev2 = [
      "opacity ${opacity},class:(neovide)"
      "opacity ${opacity},class:(kitty)"
      "opacity ${opacity},title:(Open Source Combatlog Reader)"
      "opacity ${opacity},title:(app.py)"
      "size 300 200,title:(app.py)"
      "float,title:(Open Source Combatlog Reader)"
      "float,title:(app.py)"
      "float,title:(Numeric Received)"
      "float,class:(xdg-desktop-portal-gtk)"
      "forceinput, class:^steam_app_.*$"

      # Workspace Rules
      "workspace 10 silent,class:(firefox)"
    ];

    workspace = [
      "1, monitor:DP-2, default:true"
      "10, monitor:DP-3, default:true"
    ];

    env = [
      "GDK_BACKEND=wayland,x11"
      "SDL_VIDEODRIVER=wayland"
      "CLUTTER_BACKEND=wayland"
      "QT_AUTO_SCREEN_SCALE_FACTOR=1"
      "QT_QPA_PLATFORM,wayland;xcb"
      "GBM_BACKEND=nvidia-drm"
      "__GLX_VENDOR_LIBRARY_NAME=nvidia"
      "LIBVA_DRIVER_NAME=nvidia"
      "WLR_DRM_NO_ATOMIC=1"
    ];
  };
}
