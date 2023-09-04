{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.rofi.applets;
  packages = import ./packages { inherit pkgs lib; };
in
{
  options.programs.rofi.applets = {
    enable = mkEnableOption "Rofi applets";

    apps = {
      enable = mkEnableOption "Rofi Apps applets";
    };

    quicklinks = {
      enable = mkEnableOption "Rofi Quicklinks applets";

    };

    runAsRoot = {
      enable = mkEnableOption "Rofi RunAsRoot applets";

    };

    battery = {
      enable = mkEnableOption "Rofi Battery applets";

    };

    brightness = {
      enable = mkEnableOption "Rofi Brightness applets";

    };

    volume = {
      enable = mkEnableOption "Rofi Volume applets";

    };

    mpd = {
      enable = mkEnableOption "Rofi MPD applets";

    };

    bluetooth = {
      enable = mkEnableOption "Rofi Bluetooth applets";

    };

    network = {
      enable = mkEnableOption "Rofi Network applets";

    };
  };

  config = mkIf cfg.enable {

  };
}

