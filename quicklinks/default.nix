{ pkgs, version ? "git" }:

pkgs.callPackage ../builder.nix {
  pname = "rofi-quicklinks";

  inherit version;

  src = ./.;

  buildInputs = with pkgs; [
    bash
  ];

  paths = with pkgs; [
    xdg-utils
  ];
}

