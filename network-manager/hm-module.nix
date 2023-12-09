{ package }:
{ config, lib, ... }:

with lib;
let
  cfg = config.programs.rofi.applets.network-manager;
  rofiHelpers = import ../lib { inherit lib; };
  mkSignalStrength = default: mkOption {
    inherit default;
    type = types.str;
    description = "Custom signal strength indicators.";
  };
in
{
  options.programs.rofi.applets.network-manager = {
    enable = mkEnableOption "Roi NetworkManager applet";

    theme = mkOption {
      type = rofiHelpers.themeType;
      default = null;
      description = "Define the theme config of the applet";
    };

    settings = {
      location = mkOption {
        type = types.enum [ 0 1 2 3 4 5 6 7 8 ];
        default = 0;
        description = ''
        Location:
        +---------- +
        | 1 | 2 | 3 |
        | 8 | 0 | 4 |
        | 7 | 6 | 5 |
        +-----------+
        The grid represents the screen with the numbers indicating the location of the window.
        If you want the window to be in the upper right corner, set location to 3.
        '';
      };

      qrcode_location = mkOption {
        type = types.int;
        default = cfg.settings.location;
        description = ''
        This sets the anchor point for the window displaying the QR code.
        '';
      };

      x_axis = mkOption {
        type = types.int;
        default = 0;
        description = "This sets the distance of the window from the edge of the
        screen on the X axis.";
      };

      y_axis = mkOption {
        type = types.int;
        default = 0;
        description = "This sets the distance of the window from the edge of the
        screen on the Y axis.";
      };

      notifications = mkOption {
        type = types.enum [ "true" "false" ];
        default = "false";
        description = "Use notifications or not.";
      };

      qrcode_dir = mkOption {
        type = types.nonEmptyStr;
        default = "/tmp/";
        description = "Location of QRCode WiFi image.";
      };

      width_fix_main = mkOption {
        type = types.int;
        default = 1;
        description = ''
        WIDTH_FIX_MAIN/WIDTH_FIX_STATUS
        These values can be adjusted if the text doesn't fit or
        if there is too much space at the end when you launch the script.
        It will depend on the font type and size.
        '';
      };

      width_fix_status = mkOption {
        type = types.int;
        default = 10;
        description = ''
        WIDTH_FIX_MAIN/WIDTH_FIX_STATUS
        These values can be adjusted if the text doesn't fit or
        if there is too much space at the end when you launch the script.
        It will depend on the font type and size.
        '';
      };

      ascii_out = mkOption {
        type = types.bool;
        default = false;
        description = ''
        Set it to true, if the script outputs the signal strength with asterisks
        and you want bars.
        '';
      };

      change_bars = mkOption {
        type = types.bool;
        default = false;
        description = ''
        Set it to true if you want to use custom icons
        for the signal strength instead of the default ones.
        '';
      };

      signal_strength_0 = mkSignalStrength "0";
      signal_strength_1 = mkSignalStrength "1";
      signal_strength_2 = mkSignalStrength "12";
      signal_strength_3 = mkSignalStrength "123";
      signal_strength_4 = mkSignalStrength "1234";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ package ];

    xdg.configFile = {
      "rofi/rofi-network-manager.rasi".text = strings.optionalString (cfg.theme != null)
      (rofiHelpers.toRasi cfg.theme);
      "rofi/rofi-network-manager.conf".text = rofiHelpers.toConf cfg.settings;
    };
  };
}

