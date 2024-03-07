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

  outputs = {
    nixpkgs,
    rofi-network-manager,
    ...
  }: let
    system = "x86_64-linux";
    version = "1.5.0";
  in
    with import nixpkgs {inherit system;}; let
      utils = import ./utils {inherit lib;};
    in rec {
      workspaceShell = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          brightnessctl
          mpc-cli
          mpd
          wireplumber
          pavucontrol
          bluez
          networkmanager
          libnotify
          networkmanagerapplet
          xdg-utils
          gawk
          power-profiles-daemon
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
        rofi-bluetooth = pkgs.callPackage ./bluetooth {
          inherit version;
          inherit (utils) cleanAppletSource;
        };
        rofi-quicklinks = pkgs.callPackage ./quicklinks {
          inherit version;
          inherit (utils) cleanAppletSource;
        };
        rofi-favorites = pkgs.callPackage ./favorites {
          inherit version;
          inherit (utils) cleanAppletSource;
        };
        rofi-power-profiles = pkgs.callPackage ./power-profiles {
          inherit version;
          inherit (utils) cleanAppletSource;
        };
        rofi-mpd = pkgs.callPackage ./mpd {
          inherit version;
          inherit (utils) cleanAppletSource;
        };
      };

      overlays.default = final: prev: packages.${system};

      homeManagerModules = rec {
        default = {...}: {
          imports = [
            rofi-bluetooth
            rofi-quicklinks
            rofi-network-manager
            rofi-favorites
            rofi-power-profiles
            rofi-mpd
          ];
        };

        rofi-bluetooth = import ./bluetooth/hm-module.nix {
          package = packages.${system}.rofi-bluetooth;
        };

        rofi-network-manager = import ./network-manager/hm-module.nix {
          package = packages.${system}.rofi-network-manager;
        };

        rofi-quicklinks = import ./quicklinks/hm-module.nix {
          package = packages.${system}.rofi-quicklinks;
        };

        rofi-favorites = import ./favorites/hm-module.nix {
          package = packages.${system}.rofi-favorites;
        };

        rofi-power-profiles = import ./power-profiles/hm-module.nix {
          package = packages.${system}.rofi-power-profiles;
        };

        rofi-mpd = import ./mpd/hm-module.nix {
          package = packages.${system}.rofi-mpd;
        };
      };
    };
}
