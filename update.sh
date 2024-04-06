#!/usr/bin/env bash

set -x

sudo nixos-rebuild switch --upgrade
nix-env --delete-generations 30d
nix-store --gc

files=$(find /nix/var/nix/profiles/system-* -maxdepth 1 -type l | sort | tail -n 2)
nvd diff ${files}
