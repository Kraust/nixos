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
      lightdm = {
        enable = true;
      };
    };
    desktopManager.budgie.enable = true;
  };
}
