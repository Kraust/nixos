{ config, lib, pkgs, ... }:

{
  programs.irssi = {
    enable = true;
    extraConfig = ''
      settings = {
          core = {
              real_name = "Kraust";
              user_name = "Kraust";
              nick = "Kraust";
          };
          "fe-common/core" = {
              theme = "catppuccin";
          };
          "irc/dcc" = {
              dcc_autoget = "yes";
              dcc_autoresume = "yes";
              dcc_autoget_max_size = "0k";
              dcc_download_path = "/home/kraust/Downloads/xdcc";
          }
      }
    '';
    networks = {
      rizon = {
        nick = "Kraust";
        server = {
          address = "irc.rizon.net";
          port = 9999;
          autoConnect = true;
          ssl = {
            enable = true;
            verify = true;
            certificateFile = /home/kraust/.certs/rizon.pem;
          };
        };
        channels = {
          nibl.autoJoin = true;
        };
        saslExternal = true;
      };
      abjects = {
        nick = "Kraust";
        server = {
          address = "38.154.192.115";
          port = 9999;
          autoConnect = true;
          ssl = {
            enable = true;
            verify = false;
            certificateFile = /home/kraust/.certs/abjects.pem;
          };
        };
        channels = {
            moviegods.autoJoin = true;
            mg-chat.autoJoin = true;
            mg-lounge.autoJoin = true;
        };
        saslExternal = true;
      };
    };
  };
}
