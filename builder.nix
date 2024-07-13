{
  stdenvNoCC,
  lib,
  pname,
  version,
  src,
  makeWrapper,
  rofi,
  rofi-wayland,
  buildInputs ? [],
  paths ? [],
  desktopItemPhase ? "",
  installPhase ? "",
  patches ? [],
  useWayland ? true,
}: let
  newPaths =
    paths
    ++ (
      if useWayland
      then [rofi-wayland]
      else [rofi]
    );
  wrapperPath = lib.makeBinPath newPaths;
  desktopItemPhaseName =
    if (desktopItemPhase != "")
    then "desktopItemPhase"
    else "";
in
  stdenvNoCC.mkDerivation {
    inherit pname version src buildInputs desktopItemPhase patches;

    nativeBuildInputs = [
      makeWrapper
    ];

    postPhases = [
      desktopItemPhaseName
    ];

    installPhase =
      if installPhase == ""
      then ''
        mkdir -p $out/bin
        cp ${pname}.sh $out/bin/${pname}
        chmod +x $out/bin/${pname}
      ''
      else installPhase;

    postFixup = ''
      # Ensure all dependencies are in PATH
        wrapProgram $out/bin/${pname} \
          --prefix PATH : "${wrapperPath}"
    '';

    dontUseCmakeBuild = true;
    dontUseCmakeConfigure = true;

    meta.mainProgram = pname;
  }
