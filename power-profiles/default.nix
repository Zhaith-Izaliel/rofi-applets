{ pkgs, cleanAppletSource, version ? "git" }:

pkgs.callPackage ../builder.nix {
  pname = "rofi-power-profiles";

  inherit version;

  src = cleanAppletSource ./.;

  buildInputs = with pkgs; [
    bash
  ];

  paths = with pkgs; [
    power-profiles-daemon
  ];
}
