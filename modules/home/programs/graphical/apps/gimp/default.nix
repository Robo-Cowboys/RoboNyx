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
  config = mkIf prg.gimp.enable {
    home.packages = with pkgs; [
      gimp-with-plugins
    ];
  };
}
