{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kraust";
  home.homeDirectory = "/home/kraust";

  imports = [
    # ./pantheon.nix
    ./hyprland.nix
    ./kitty.nix
  ];

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
      historyFileSize = 1000000;
      initExtra =
      ''
      set_prompt() {
        branch=$(git branch 2> /dev/null | grep '*' )
        if [ $? -eq 0 ]
          then
            pwd=$(basename "$(git rev-parse --show-toplevel 2> /dev/null)")
            export PS1="$pwd $branch> "
          else
            pwd=$(basename "$PWD")
            export PS1="$pwd> "
        fi
      }
      PROMPT_COMMAND=set_prompt
      '';
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

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Rosewater-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [
          "rosewater"
        ];
        size = "compact";
        tweaks = [ 
          "rimless"
        ];
        variant = "mocha";
      };
    };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  services.mako = {
    enable = true;
    defaultTimeout = 60000;
    backgroundColor = "#1e1e2e";
    textColor = "#cdd6f4";
    borderColor = "#89b4fa";
    progressColor = "over #313244";
  };
}
