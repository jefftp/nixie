#!/usr/bin/env bash

# Run Disko to partition disks
nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disko/btrfs.nix

# Generate initial configs
nixos-generate-config --no-filesystems --root /mnt

# Copy flake to /etc/nixos/nixie
cp -r . /mnt/etc/nixos/nixie
