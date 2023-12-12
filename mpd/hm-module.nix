{ package }:
{ config, lib, ... }:

let
  inherit (lib) mkOption mkIf mkEnableOption strings types;
  cfg = config.programs.rofi.applets.mpd;
  rofiHelpers = import ../lib { inherit lib; };
  mkTextOption = default: description: mkOption {
    inherit default;
    description = "Defines the text that appears ${description}.";
    type = types.nonEmptyStr;
  };
in
{
  options.programs.rofi.applets.mpd = {
    enable = mkEnableOption "Rofi MPD applet";

    package = mkOption {
      type = types.package;
      default = package;
      description = "Package providing the Rofi MPD applet.";
    };

    settings = {
      stop_text = mkTextOption "" "to stop the current song";

      previous_text = mkTextOption "" "to play the previous song";

      next_text = mkTextOption "" "to play the next song";

      repeat_text = mkTextOption "" "to repeat the current song";

      random_text = mkTextOption "" "to shuffle the playlist";

      pause_text = mkTextOption "" "to pause the current song";

      play_text = mkTextOption "" "to play the current song";

      parse_error_text = mkTextOption "" "when mpc encounters an error";

      no_song_text = mkTextOption "󰟎" "when no song is currently played or
      paused";
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

