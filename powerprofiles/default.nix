{ pkgs, version ? "git" }:

pkgs.callPackage ../builder.nix {
  pname = "rofi-powerprofiles";

  inherit version;

  src = ./.;

  buildInputs = with pkgs; [
    bash
  ];

  paths = with pkgs; [
    power-profiles-daemon
  ];
}

