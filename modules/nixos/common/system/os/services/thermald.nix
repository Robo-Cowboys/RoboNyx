{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  roles = config.my.roles;
in {
  config = mkIf roles.common {
    # monitor and control temparature
    services.thermald.enable = true;
  };
}
