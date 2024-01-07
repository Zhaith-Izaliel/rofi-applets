{ pkgs, cleanAppletSource, version ? "git" }:

pkgs.callPackage ../builder.nix {
  pname = "rofi-favorites";

  inherit version;

  src = cleanAppletSource ./.;

  buildInputs = with pkgs; [
    bash
  ];

  paths = with pkgs; [
    rofi-wayland
  ];
}

