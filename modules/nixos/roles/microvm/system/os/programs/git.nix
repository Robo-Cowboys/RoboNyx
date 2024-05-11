{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.my.modules.microvm {
    programs.git.enable = true;
  };
}
