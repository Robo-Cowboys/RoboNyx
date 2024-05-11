{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.my.roles.microvm {
    programs.git.enable = true;
  };
}
