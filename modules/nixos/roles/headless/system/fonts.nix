{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.my.modules.headless {
    # we don't need fontconfig on a server
    # since there are no fonts to be configured outside the console
    fonts.fontconfig.enable = lib.mkDefault false;
  };
}
