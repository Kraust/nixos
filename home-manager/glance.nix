# vim: set sw=2:

{ config, lib, pkgs, ... }:
{
  services.glance = {
      enable = true;
      settings = {
        server.port = 9000;
        theme = {
          background-color = "240 21 15";
          contrast-multiplier = 1.2;
          primary-color = "217 92 83";
          positive-color = "115 54 76";
          negative-color = "347 70 65";
        };
        pages = [{
          name = "Home";
          columns = [
            {
              size = "small";
              widgets = [
                {
                  type = "clock";
                  hour-format = "12h";
                  timezones = [
                    { timezone = "America/Los_Angeles"; label = "Pacific"; }
                    { timezone = "Etc/UTC"; label = "UTC"; }
                    { timezone = "Asia/Tashkent"; label = "Uzbekistan"; }
                    { timezone = "Asia/Calcutta"; label = "India"; }
                  ];
                }
                {
                  type = "calendar"; 
                }
                {
                  type = "weather";
                  units = "imperial";
                  location = "01826";
                  hour-format = "12h";
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "search";
                  search-engine = "google";
                }
              ];
            }
            {
              size = "small";
              widgets = [
                {
                  type = "monitor";
                  sites = [
                    {
                      title = "OSCR";
                      url = "https://oscr.stobuilds.com";
                    }
                    {
                      title = "hpg10-2";
                      url = "https://hpg10-2.eng.cspi.com";
                      allow-insecure = true;
                    }
                    {
                      title = "hpg10-2-nixos";
                      url = "http://hpg10-2-nixos.eng.cspi.com";
                    }
                    {
                      title = "vcenter";
                      url = "https://vcenter.eng.cspi.com";
                      allow-insecure = true;
                    }
                  ];
                }
                {
                  type = "markets";
                  markets = [
                    { symbol = "CSPI"; name = "CSP Inc"; }
                    { symbol = "PODD"; name = "Insulet"; }
                  ];
                }
              ];
            }
          ];
        }];
      };
  };
}
