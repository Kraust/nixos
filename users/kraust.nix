{ pkgs, ... }:

{
  home-manager.users.kraust = {
    imports = [
      <catppuccin/modules/home-manager>
      ../home-manager/hyprland.nix
      ../home-manager/hyprpaper.nix
      ../home-manager/kitty.nix
      ../home-manager/glance.nix
      ../home-manager/irssi.nix
    ];
    home = {
      username = "kraust";
      homeDirectory = "/home/kraust";

      stateVersion = "23.11";
      enableNixpkgsReleaseCheck = false;
      packages = with pkgs; [
        (pkgs.symlinkJoin {
          name = "neovim";
          paths = [ pkgs.neovim ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/nvim --set LD_LIBRARY_PATH ${lib.makeLibraryPath [pkgs.libgit2]} --prefix PATH : ${lib.makeBinPath [
              python3
              (python3.withPackages (ps: with ps; [ python-lsp-server python-lsp-jsonrpc python-lsp-black python-lsp-ruff pyls-isort pyls-flake8 flake8 isort black ]))

              nodejs
              vscode-langservers-extracted
              # nodePackages_latest.bash-language-server

              yaml-language-server
              java-language-server
              # cmake-language-server
              gopls
              clang-tools
              nil
              nixd
              lua5_1
              lua51Packages.luarocks
              lua-language-server
              nixpkgs-fmt
            ]}

          '';
        })
        (pkgs.symlinkJoin {
          name = "neovide";
          paths = [ pkgs.neovide ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/neovide --set LD_LIBRARY_PATH ${lib.makeLibraryPath [pkgs.libgit2]} --prefix PATH : ${lib.makeBinPath [
              python3
              (python3.withPackages (ps: with ps; [ python-lsp-server python-lsp-jsonrpc python-lsp-black python-lsp-ruff pyls-isort pyls-flake8 flake8 isort black ]))

              nodejs
              vscode-langservers-extracted
              # nodePackages_latest.bash-language-server

              yaml-language-server
              java-language-server
              # cmake-language-server
              gopls
              clang-tools
              nil
              nixd
              lua5_1
              lua51Packages.luarocks
              lua-language-server
              nixpkgs-fmt
            ]}

          '';
        })

        firefox-bin
        hexchat
        fzf
        ripgrep
        neofetch
        pciutils
        usbutils
        obs-studio
        git
        sshfs
        nodejs
        qbittorrent
        libreoffice-qt
        gimp
        fish

        python3

        # MPV
        (mpv.override { scripts = [ mpvScripts.mpris ]; })
        yad
        ffmpeg
        kdialog
        mkvtoolnix
        imagemagick

        # Gaming
        steam
        mangohud
        lutris
        gamemode

        # go
        go

        opentabletdriver

        home-manager
        xdg-desktop-portal
        virtualenv
        pre-commit
        protontricks
        protonup
        protonup-qt
        nvd
        nix-output-monitor
        btop
        hyprpaper
        chromium
        wireshark
        alacritty
        busybox
        clipnotify
        winetricks

        lua5_1
        lua51Packages.luarocks
        lua-language-server

        dbus
        wayland
        kitty
        sway-contrib.grimshot
        mako
        glib
        xdg-utils
        cinnamon.nemo-with-extensions
        cinnamon.pix
        playerctl
        wl-clipboard
        xclip
        ulauncher
        ranger
        irssi
        fastfetch
        openconnect
        jq

      ];
    };
    programs = {

      fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting # Disable greeting
        '';
        plugins = [
          {
            name = "tide";
            src = pkgs.fetchFromGitHub {
              owner = "IlanCosman";
              repo = "tide";
              rev = "44c521ab292f0eb659a9e2e1b6f83f5f0595fcbd";
              sha256 = "sha256-ZyEk/WoxdX5Fr2kXRERQS1U1QHH3oVSyBQvlwYnEYyc=";
            };
          }
        ];
        shellAliases = {
          home = "cd /home/$USER/";
        };
      };

      fzf = {
        enable = true;
      };

    };
    fonts.fontconfig.enable = true;

    catppuccin = {
      enable = true;
      flavor = "mocha";
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
  };
}
