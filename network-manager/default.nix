{
  pkgs,
  version ? "git",
  useWayland ? true,
  src
}:

pkgs.callPackage ../builder.nix {
  pname = "rofi-network-manager";

  inherit version src useWayland;

  buildInputs = with pkgs; [
    bash
  ];

  paths = with pkgs; [
    libnotify
    qrencode
    networkmanagerapplet
    networkmanager
  ];
}

