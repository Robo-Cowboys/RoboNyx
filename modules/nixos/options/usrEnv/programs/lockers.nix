{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.types) package;
  inherit (lib.options) mkEnableOption mkOption;

  cfg = config.my.usrEnv.programs.screenlock;
  pkg =
    if cfg.gtklock.enable
    then pkgs.gtklock
    else pkgs.swaylock-effects;
in {
  options.my.usrEnv.programs.screenlock = {
    gtklock.enable = mkEnableOption "gtklock screenlocker";
    swaylock.enable = mkEnableOption "swaylock screenlocker";

    package = mkOption {
      type = package;
      default = pkg;
      readOnly = true;
      description = "The screenlocker package";
    };
  };
}
