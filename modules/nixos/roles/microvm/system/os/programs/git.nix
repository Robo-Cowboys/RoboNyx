{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.modules.roles.microvm {
    programs.git.enable = true;
  };
}
