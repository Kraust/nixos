{ pkgs, lib, ... }:

{

  home-manager.users.kraust = {
    imports = [
      ../home-manager/ranger.nix
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
              # vscode-langservers-extracted
              # nodePackages_latest.bash-language-server

              yaml-language-server
              java-language-server
              cmake-language-server
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
              # vscode-langservers-extracted
              # nodePackages_latest.bash-language-server

              yaml-language-server
              java-language-server
              cmake-language-server
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
        ripgrep
        nitch
        pciutils
        usbutils
        obs-studio
        sshfs
        libreoffice-qt
        gimp
        python3

        # MPV
        yad
        ffmpeg
        kdialog
        mkvtoolnix
        imagemagick

        # Gaming
        (steam.override {
          extraPkgs = pkgs: with pkgs; [
            gamescope
            mangohud
          ];
        })

        go

        opentabletdriver

        virtualenv
        pre-commit
        protontricks
        protonup
        protonup-qt
        nvd
        nix-output-monitor
        wireshark
        alacritty
        clipnotify
        winetricks
        wineWowPackages.waylandFull
        jq
        lsd
        gwe
        wxhexeditor
        killall
        moonlight-qt

        winetricks
        bottles
        slack
        rocmPackages.rocm-smi

        btop
        fastfetch
        wl-clipboard

        (lutris.override {
          extraPkgs = pkgs: [
            attr
            gamescope
            mangohud
            libthai
            pango
            gtk3
          ];
          extraLibraries = pkgs: [
            attr
          ];
        })

        (callPackage ../software/cpu-speed.nix { })
      ];
    };
    programs = {
      fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting # Disable greeting
          alias ls "lsd"
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

      rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        plugins = with pkgs; [
          rofi-calc
          rofi-emoji
          rofi-top
          rofi-systemd
          rofi-power-menu
          rofi-file-browser
        ];
        extraConfig = {
          # modi = "drun";
        };
      };

      fzf = {
        enable = true;
      };

      mpv = {
        enable = true;
      };

      git = {
        enable = true;
      };

      home-manager = {
        enable = true;
      };

    };
    fonts.fontconfig.enable = true;

    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    };
  };
}
