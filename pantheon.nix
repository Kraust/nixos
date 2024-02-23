{ pkgs, ... }:

# Reference: https://github.com/wimpysworld/nix-config/blob/main/nixos/_mixins/desktop/pantheon.nix

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
      lightdm.enable = true;
      lightdm.greeters.pantheon.enable = true;
    };
    desktopManager.pantheon = {
      enable = true;
      extraWingpanelIndicators = with pkgs; [
        monitor
        wingpanel-indicator-ayatana
      ];
    };
  };

  programs.pantheon-tweaks.enable = true;

  environment = {
    pantheon.excludePackages = with pkgs.pantheon; [
      elementary-camera
      elementary-code
      elementary-music
      elementary-photos
      elementary-videos
      epiphany
    ];

    # App indicator
    # - https://discourse.nixos.org/t/anyone-with-pantheon-de/28422
    # - https://github.com/NixOS/nixpkgs/issues/144045#issuecomment-992487775
    pathsToLink = [ "/libexec" ];
  };

  # App indicator
  # - https://github.com/NixOS/nixpkgs/issues/144045#issuecomment-992487775
  systemd.user.services.indicator-application-service = {
    description = "indicator-application-service";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.indicator-application-gtk3}/libexec/indicator-application/indicator-application-service";
    };
  };
}
