{
  pkgs,
  cleanAppletSource,
  useWayland ? true,
  version ? "git"
}:

pkgs.callPackage ../builder.nix {
  pname = "rofi-favorites";

  inherit version useWayland;

  src = cleanAppletSource ./.;

  buildInputs = with pkgs; [
    bash
  ];

  paths = [];
}

