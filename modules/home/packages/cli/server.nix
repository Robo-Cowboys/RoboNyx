{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) my;

  prg = my.system.programs;
  dev = my.device;
in {
  config = mkIf (prg.cli.enable && (builtins.elem dev.type ["server" "hybrid"])) {
    home.packages = with pkgs; [
    ];
  };
}
