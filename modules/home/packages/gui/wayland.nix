{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.my) isWayland;
  inherit (osConfig) my;
  sys = my.system;
  prg = sys.programs;
in {
  config = mkIf (prg.gui.enable && (isWayland osConfig)) {
    home.packages = with pkgs; [
      wlogout
      swappy
    ];
  };
}
