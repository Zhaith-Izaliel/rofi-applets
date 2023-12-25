{ package }:
{ config, lib, ... }:

let
  inherit (lib) mkOption mkIf mkEnableOption strings types;
  cfg = config.programs.rofi.applets.powerprofiles;
  rofiHelpers = import ../lib { inherit lib; };
  mkTextOption = default: description: mkOption {
    inherit default description;
    type = types.nonEmptyStr;
  };
in
{
  options.programs.rofi.applets.power-profiles = {
    enable = mkEnableOption "Rofi Powerprofiles applet";

    package = mkOption {
      type = types.package;
      default = package;
      description = "Package providing the Rofi Powerprofiles applet.";
    };

    settings = {
      prompt = mkTextOption "Power Profiles Daemon" "The Rofi prompt";
    };

    theme = mkOption {
      type = rofiHelpers.themeType;
      default = null;
      description = "Rasi configuration used with the applet for Rofi.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ package ];
    xdg.configFile = {
      "rofi/rofi-power-profiles.rasi".text = strings.optionalString (cfg.theme != null)
      (rofiHelpers.toRasi cfg.theme);
      "rofi/rofi-power-profiles.conf".text = rofiHelpers.toConf cfg.settings;
    };
  };
}

