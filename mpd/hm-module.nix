{ package }:
{ config, lib, ... }:

let
  inherit (lib) mkOption mkIf mkEnableOption strings types;
  cfg = config.programs.rofi.applets.mpd;
  rofiHelpers = import ../utils { inherit lib; };
  inherit (rofiHelpers) mkTextOption;
  mkIconOption = desc: mkOption {
    type = types.oneOf [
      types.path
      types.str
    ];
    default = "";
    description = "Set the icon of the notification when ${desc}.";
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

      previous_text = mkTextOption "󰒮" "to play the previous song";

      next_text = mkTextOption "󰒭" "to play the next song";

      repeat_text = mkTextOption "" "to repeat the current song";

      random_text = mkTextOption "" "to shuffle the playlist";

      pause_text = mkTextOption "" "to pause the current song";

      play_text = mkTextOption "" "to play the current song";

      parse_error_text = mkTextOption "" "when mpc encounters an error";

      no_song_text = mkTextOption "󰟎" "when no song is currently played or
      paused";

      notification = mkOption {
        type = types.bool;
        default = true;
        description = "Enable notifications when pausing, playing and switching
        song.";
      };

      previous_notification_text = mkTextOption "󰒮 Playing" "in the
      notification, when playing the previous song";

      previous_notification_icon = mkIconOption "playing the previous song";

      next_notification_text = mkTextOption "󰒭 Playing" "in the notification,
      when playing the next song";

      next_notification_icon = mkIconOption "playing the next song";

      play_notification_text = mkTextOption " Playing" "in the notification,
      when playing the song";

      play_notification_icon = mkIconOption "unpausing";

      pause_notification_text = mkTextOption " Pausing" "in the notification
      when pausing the song";

      pause_notification_icon = mkIconOption "pausing";
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
      "rofi/rofi-mpd.rasi".text = strings.optionalString (cfg.theme != null)
      (rofiHelpers.toRasi cfg.theme);
      "rofi/rofi-mpd.conf".text = rofiHelpers.toConf cfg.settings;
    };
  };
}

