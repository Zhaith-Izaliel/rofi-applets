{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rofi-network-manager = {
      url = "github:P3rf/rofi-network-manager";
      flake = false;
    };
  };

  outputs = inputs @ {
    flake-parts,
    rofi-network-manager,
    nixpkgs,
    ...
  }: let
    version = "2.0.0";
  in
    flake-parts.lib.mkFlake {inherit inputs;} ({withSystem, ...}: {
      systems = ["x86_64-linux"];

      perSystem = {
        pkgs,
        system,
        inputs',
        ...
      }: let
        utils = import ./utils {lib = nixpkgs.lib;};
      in {
        devShells = {
          default = pkgs.mkShell {
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
        };

        packages = {
          ronema = pkgs.callPackage ./ronema {
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
      };

      flake = let
        getPackage = pkgs': name: withSystem pkgs'.stdenv.hostPlatform.system ({config, ...}: config.packages.${name});
      in {
        homeManagerModules = rec {
          default = {...}: {
            imports = [
              rofi-bluetooth
              rofi-quicklinks
              ronema
              rofi-favorites
              rofi-power-profiles
              rofi-mpd
            ];
          };

          rofi-bluetooth = {pkgs, ...}: let
            hm-module = import ./bluetooth/hm-module.nix {
              package = getPackage pkgs "rofi-bluetooth";
            };
          in {
            imports = [hm-module];
          };

          ronema = {pkgs, ...}: let
            hm-module = import ./ronema/hm-module.nix {
              package = getPackage pkgs "ronema";
            };
          in {
            imports = [hm-module];
          };

          rofi-quicklinks = {pkgs, ...}: let
            hm-module = import ./rofi-quicklinks/hm-module.nix {
              package = getPackage pkgs "rofi-quicklinks";
            };
          in {
            imports = [hm-module];
          };

          rofi-favorites = {pkgs, ...}: let
            hm-module = import ./rofi-favorites/hm-module.nix {
              package = getPackage pkgs "rofi-favorites";
            };
          in {
            imports = [hm-module];
          };

          rofi-power-profiles = {pkgs, ...}: let
            hm-module = import ./rofi-power-profiles/hm-module.nix {
              package = getPackage pkgs "rofi-power-profiles";
            };
          in {
            imports = [hm-module];
          };

          rofi-mpd = {pkgs, ...}: let
            hm-module = import ./rofi-mpd/hm-module.nix {
              package = getPackage pkgs "rofi-mpd";
            };
          in {
            imports = [hm-module];
          };
        };

        overlays.default = {pkgs, ...}: let
          packages = withSystem pkgs.stdenv.hostPlatform.system ({config, ...}: config.packages);
        in
          final: prev: packages;
      };
    });
}
