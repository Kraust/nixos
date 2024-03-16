{
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    displayManager = {
      autoLogin = {
        enable = true;
        user = "kraust";
      };
      gdm = {
        enable = true;
      };
    };
    desktopManager.gnome.enable = true;
  };
}
