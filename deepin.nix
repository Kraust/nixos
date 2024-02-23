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
      sddm = {
        enable = true;
      };
    };
    desktopManager.deepin.enable = true;
  };
}
