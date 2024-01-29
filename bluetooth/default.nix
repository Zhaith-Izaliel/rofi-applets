{
  pkgs,
  cleanAppletSource,
  useWayland ? true,
  version ? "git",
}:
pkgs.callPackage ../builder.nix {
  pname = "rofi-bluetooth";

  inherit version useWayland;

  src = cleanAppletSource ./.;

  buildInputs = with pkgs; [
    bash
  ];

  paths = with pkgs; [
    bluez
    gnugrep
  ];
}
