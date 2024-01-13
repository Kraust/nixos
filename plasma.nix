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
    desktopManager.plasma5.enable = true;
  };
}
