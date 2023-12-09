{ package }:
{ config, lib, ... }:

let
  inherit (lib) mkOption mkIf mkEnableOption strings mkLiteral types;
  cfg = config.programs.rofi.applets.bluetooth;
  rofiHelpers = import ../lib { inherit lib; };
  mkTextOption = default: description: mkOption {
    inherit default description;
    type = types.nonEmptyStr;
  };
in
{
  options.programs.rofi.applets.bluetooth = {
    enable = mkEnableOption "Rofi Quicklinks applet";

    package = mkOption {
      type = types.package;
      default = package;
      description = "Package providing the Rofi Quicklinks applet.";
    };

    settings = {
      quicklinks = {
        type = rofiHelpers.associativeArray;
        description = "The quicklinks to open in Rofi. The order is not respected";
        defaultText = mkLiteral ''
          {
            " Reddit" = "https://www.reddit.com/";
            " Youtube" = "https://www.youtube.com/";
            " Gitlab" = "https://gitlab.com/";
            " Steam" = "https://store.steampowered.com/";
          }
        '';
      };

      order = {
        type = types.listOf types.str;
        default = [];
        description = "The order in which the quicklinks appear. Can be empty.";
      };

      prompt = mkTextOption "Quicklinks" "The Rofi prompt";

      mesg = mkTextOption "Open a link" "The Rofi message.";
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
      "rofi/rofi-quicklinks.rasi".text = strings.optionalString (cfg.theme != null)
      (rofiHelpers.toRasi cfg.theme);
      "rofi/rofi-quicklinks.conf".text = rofiHelpers.toConf cfg.settings;
    };
  };
}

