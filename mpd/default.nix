{ pkgs, version ? "git" }:

pkgs.callPackage ../builder.nix {
  pname = "rofi-mpd";

  inherit version;

  src = ./.;

  buildInputs = with pkgs; [
    bash
  ];

  paths = with pkgs; [
    mpc-cli
  ];
}

