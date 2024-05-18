{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  prg = osConfig.modules.system.programs;
in {
  config = mkIf prg.dev.enable {
    home.packages = with pkgs; [
      jetbrains.datagrip
      jetbrains.phpstorm
      jetbrains.pycharm-professional
    ];
  };
}
