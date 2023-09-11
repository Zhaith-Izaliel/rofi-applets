{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    rofi-network-manager = {
      url = "github:P3rf/rofi-network-manager";
      flake = false;
    };
  };

  outputs = { nixpkgs, flake-utils, rofi-network-manager, ... }:
  flake-utils.lib.eachDefaultSystem (system:
    with import nixpkgs { inherit system; };
    let
      version = "1.0.0";
    in
    rec {
      workspaceShell = pkgs.mkShell {
        # nativeBuildInputs is usually what you want -- tools you need to run
        nativeBuildInputs = with pkgs; [
          rofi
          acpi
          polkit
          powerstat
          brightnessctl
          mpc-cli
          mpd
          wireplumber
          pavucontrol
          bluez
          networkmanager
          dunst
          networkmanagerapplet
          xdg-utils
        ];
      };

      devShells = {
        # nix develop
        default = workspaceShell;
      };
      packages = {
        rofi-network-manager = pkgs.callPackage ./network-manager {
          version = rofi-network-manager.shortRev;
          src = rofi-network-manager;
        };
        rofi-bluetooth = pkgs.callPackage ./bluetooth { inherit version; };
      };
      overlays.default = packages;
    }) // {
      homeManagerModules = rec {
        all = [];
      };
    };
}

