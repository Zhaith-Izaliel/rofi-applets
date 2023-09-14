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
    hyprland-contrib.url="github:hyprwm/contrib";
  };

  outputs = { nixpkgs, rofi-network-manager, hyprland-contrib, ... }:
  let
    system = "x86_64-linux";
    version = "1.0.0";
  in
  with import nixpkgs { inherit system; };
  rec {
    workspaceShell = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        acpi
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
        hyprland-contrib.packages.${system}.grimblast
      ];
    };

    devShells.${system} = {
      default = workspaceShell;
    };

    packages.${system} = {
      rofi-network-manager = pkgs.callPackage ./network-manager {
        version = rofi-network-manager.shortRev;
        src = rofi-network-manager;
      };
      rofi-bluetooth = pkgs.callPackage ./bluetooth { inherit version; };
    };

    overlays.default = final: prev: packages.${system};

    homeManagerModules = rec {
      all = [
        rofi-bluetooth
        rofi-network-manager
      ];

      rofi-bluetooth = import ./bluetooth/hm-module.nix {
        package = packages.${system}.rofi-bluetooth;
      };

      rofi-network-manager = import ./network-manager/hm-module.nix {
        package = packages.${system}.rofi-network-manager;
      };
    };
  };
}

