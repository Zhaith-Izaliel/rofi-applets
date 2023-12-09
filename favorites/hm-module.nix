{ package }:
{ config, lib, ... }:

with lib;
let
  cfg = config.programs.rofi.applets.favorites;
  rofiHelpers = import ../lib { inherit lib; };
  mkTextOption = default: description: mkOption {
    inherit default description;
    type = types.nonEmptyStr;
  };
in
{
  options.programs.rofi.applets.favorites = {
    enable = mkEnableOption "Rofi Favorites applet";

    package = mkOption {
      type = types.package;
      default = package;
      description = "Package providing the Rofi Favorites applet.";
    };

    settings = {
      favorites = mkOption {
        type = rofiHelpers.associativeArray;
        description = ''
        An attribute set of `name = "command"`, where `command` is the path,
        string, or command you wish to run with rofi. The order is not
        respected.
        '';
        default = {
          " Kitty" = "kitty";
          "Nemo" = "nemo";
          " Firefox" = "Firefox";
          " Neovim" = "kitty -e nvim";
          " NCMPCPP" = "kitty -e ncmpcpp";
        };
      };

      order = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "The order in which the favorites appear. Can be empty.";
      };

      prompt = mkTextOption "Favorites" "The Rofi prompt";

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
      "rofi/rofi-bluetooth.rasi".text = strings.optionalString (cfg.theme != null)
      (rofiHelpers.toRasi cfg.theme);
      "rofi/rofi-bluetooth.conf".text = rofiHelpers.toConf cfg.settings;
    };
  };
}

