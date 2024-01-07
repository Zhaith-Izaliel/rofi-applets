{ pkgs, version ? "git", src }:

pkgs.callPackage ../builder.nix {
  pname = "rofi-network-manager";

  inherit version src;

  buildInputs = with pkgs; [
    bash
  ];

  paths = with pkgs; [
    libnotify
    qrencode
    networkmanagerapplet
    networkmanager
    rofi-wayland
  ];
}

