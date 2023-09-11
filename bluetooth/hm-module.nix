{ package }:
{ config, lib, ... }:

with lib;
let
  cfg = config.programs.rofi.applets.bluetooth;
  rofiHelpers = import ../lib { inherit lib; };
  mkTextOption = default: description: mkOption {
    inherit default description;
    type = types.nonEmptyStr;
  };
in
{
  options.programs.rofi.applets.bluetooth = {
    enable = mkEnableOption "Rofi bluetooth applet";

    package = mkOption {
      type = types.package;
      default = package;
      description = "Package providing the rofi bluetooth applet.";
    };

    settings = {
      divider = mkTextOption "------" "Divider shown between bluetooth options
      and devices.";
      go_back_text = mkTextOption "Back" "Go back text.";
      scan_on_text = mkTextOption "Scan: On" "Scan on text.";
      scan_off_text = mkTextOption "Scan: Off" "Scan off text.";
      scanning_text = mkTextOption "Scanning..." "Scanning text.";
      pairable_on_text = mkTextOption "Pairable: On" "Pairable on text.";
      pairable_off_text = mkTextOption "Pairable: Off" "Pairable off text.";
      discoverable_on_text = mkTextOption "Discoverable: On" "Discoverable on
      text.";
      discoverable_off_text = mkTextOption "Discoverable: Off" "Discoverable off
      text.";
      power_on_text = mkTextOption "Power: On" "Power on text.";
      power_off_text = mkTextOption "Power: Off" "Power off text.";
      trusted_yes_text = mkTextOption "Trusted: Yes" "Trusted yes text.";
      trusted_no_text = mkTextOption "Trusted: No" "Trusted no text.";
      connected_yes_text = mkTextOption "Connected: Yes" "Connected yes text.";
      connected_no_text = mkTextOption "Connected: No" "Connected no text.";
      paired_yes_text = mkTextOption "Paired: Yes" "Paired yes text.";
      paired_no_text = mkTextOption "Paired: No" "Paired no text.";
      no_option_text = mkTextOption "No option chosen." "No option text.";
    };

    themeConfig = mkOption {
      type = rofiHelpers.themeType;
      default = null;
      description = "Rasi configuration used with the applet for Rofi.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ package ];
    xdg.configFile = {
      "rofi/rofi-bluetooth.rasi".text = mkIf cfg.themeConfig != null
      (rofiHelpers.toRasi cfg.themeConfig);
      "rofi/rofi-bluetooth.conf".text = rofiHelpers.toConf cfg.settings;
    };
  };
}

