{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = inputs: with inputs;
  flake-utils.lib.eachDefaultSystem (system:
    with import nixpkgs { inherit system; };
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
          xdg-utils
        ];
      };

      devShells = {
        # nix develop
        "${system}".default = workspaceShell;
        default = workspaceShell;
      };
      packages = {
        shell = devShells.default;
      };
    }
  );
}

