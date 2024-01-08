{
  pkgs,
  cleanAppletSource,
  useWayland ? true,
  version ? "git"
}:

pkgs.callPackage ../builder.nix {
  pname = "rofi-quicklinks";

  inherit version useWayland;

  src = cleanAppletSource ./.;

  buildInputs = with pkgs; [
    bash
  ];

  paths = with pkgs; [
    xdg-utils
  ];
}

