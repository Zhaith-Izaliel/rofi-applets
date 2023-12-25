{ pkgs, lib, version ? "git" }:

pkgs.callPackage ../builder.nix {
  pname = "rofi-favorites";

  inherit version;

  src = lib.sources.sourceFilesBySuffices [".nix"] ( lib.cleanSource ./. );

  buildInputs = with pkgs; [
    bash
  ];

  paths = with pkgs; [
    bluez
  ];
}

