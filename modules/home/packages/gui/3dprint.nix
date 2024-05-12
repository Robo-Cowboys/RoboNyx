{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) my;

  sys = my.system;
  prg = sys.programs;
in {
  config = mkIf (prg.gui.enable && sys.printing."3d".enable) {
    home.packages = with pkgs; [
      orca-slicer
      prusa-slicer
      openscad-unstable
    ];
  };
}
