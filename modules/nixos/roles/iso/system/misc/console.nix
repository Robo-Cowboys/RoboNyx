{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
in {
  config = mkIf config.my.modules.iso {
    # console locale
    console = let
      variant = "u24n";
    in {
      # hidpi terminal font
      font = "${pkgs.terminus_font}/share/consolefonts/ter-${variant}.psf.gz";
      keyMap = "trq";
    };
  };
}
