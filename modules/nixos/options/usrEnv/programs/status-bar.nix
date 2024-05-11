{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.my.usrEnv.wayland.statusBar = {
    ags.enable = mkEnableOption "ags status bar";
    waybar.enable = mkEnableOption "waybar status bar";
  };
}
