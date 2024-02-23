{ config, pkgs, ... }:

{
    programs.kitty = {
        enable = true;
        theme = "Catppuccin-Mocha";
        font = {
            name = "Fira Code";
            size = 8;
        };
    };
}
