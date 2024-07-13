{
  pkgs,
  version ? "git",
  useWayland ? true,
  src,
}: (pkgs.callPackage ../builder.nix {
  pname = "ronema";

  inherit version src useWayland;

  buildInputs = with pkgs; [
    bash
  ];

  installPhase = ''
    mkdir -p $out
    mkdir -p $out/bin
    cp -r -t $out src/themes src/languages src/icons src/ronema.conf
    cp src/ronema $out/bin
  '';

  patches = [./fix-hm-config-priority.patch];

  paths = with pkgs; [
    libnotify
    qrencode
    networkmanagerapplet
    networkmanager
  ];
})
