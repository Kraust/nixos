# vim: set shiftwidth=2

{ config, lib, pkgs, ... }:
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
      "$mod, F, resizeactive, exact 1920 1080"
      "$mod, R, exec, hyprctl reload"
      "$mod, V, exec, notify-send \"$(nmcli con up id CSPi 2>&1)\""
      "$mod, Space, exec, wofi --show=drun"

      ", print, exec, grimshot savecopy area ~/Pictures/Screenshots/$(date +%Y%m%d%H%M%S).png"
      "$mod, print, exec, grimshot savecopy active ~/Pictures/Screenshots/$(date +%Y%m%d%H%M%S).png"
    ]
    ++ (
      # workspaces
      # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
      builtins.concatLists (builtins.genList (
        x: let
          ws = let
            c = (x + 1) / 10;
          in
            builtins.toString (x + 1 - (c * 10));
        in [
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
      ", XF86AudioPlay, exec, playerctl play-pause"
    ];

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    monitor = [
      "DP-2, 3840x2160, 0x0, 1"
      "DP-3, 3840x2160, 3840x0, 1"
    ];

    general = {
      border_size = "0";
      gaps_in = "0";
      gaps_out = "0";
    };

    animations = {
      enabled = false;
    };

    exec-once = [
      "mako"
      "hyprpaper"
      "[workspace 1 silent] LD_LIBRARY_PATH=/run/opengl-driver/lib kitty btop"
      "[workspace 1 silent] kvirc"
      "[workspace 1 silent] nemo"
      "[workspace 2 silent] nvim-qt"
      "[workspace 3 silent] ~/bin/hpg10-2"
      "[workspace 4 silent] steam"
      "[workspace 5 silent] remmina"
      "[workspace 10 silent] firefox"
    ];

    exec = [
      "dbus-sway-environment"
      "configure-gtk"
    ];

    windowrulev2 = [
      "opacity 0.9,class:(nvim-qt)"
      "opacity 0.9,class:(kitty)"
      "opacity 0.9,class:(nemo)"
    ];

    workspace = [
      "1, monitor:DP-2, default:true"
      "10, monitor:DP-3, default:true"
    ];
  };
}
