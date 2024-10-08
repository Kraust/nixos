#!/usr/bin/env bash

set -x

cd $(realpath $(dirname "$0"))

nix flake update
nixos-rebuild switch --flake
nix-env --delete-generations 30d
nix-store --gc
# nix-collect-garbage -d
nixos-rebuild boot

files=$(find /nix/var/nix/profiles/system-* -maxdepth 1 -type l | sort | tail -n 2)
nvd diff ${files}
