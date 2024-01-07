{ package }:
{ config, lib, ... }:

let
  inherit (lib) mkOption mkIf mkEnableOption strings types;
  cfg = config.programs.rofi.applets.power-profiles;
  rofiHelpers = import ../utils { inherit lib; };
  inherit (rofiHelpers) mkTextOption;
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
      prompt = mkTextOption "Power Profiles Daemon" "The Rofi prompt.";
      exit_text = mkTextOption "Exit" "The exit text.";
      performance_text = mkTextOption "Performance" "The text used for the
      performance profile.";
      balanced_text = mkTextOption "Balanced" "The text used for the balanced
      profile.";
      power_saver_text = mkTextOption "Power saver" "The text used for the
      power-saver.";
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

