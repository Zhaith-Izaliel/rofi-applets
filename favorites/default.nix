{ pkgs, version ? "git" }:

pkgs.callPackage ../builder.nix {
  pname = "rofi-favorites";

  inherit version;

  src = ./.;

  buildInputs = with pkgs; [
    bash
  ];

  paths = with pkgs; [
    bluez
  ];
}

