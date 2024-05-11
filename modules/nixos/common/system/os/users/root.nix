{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  roles = config.my.roles;
in {
  config = mkIf roles.common {
    users.users.root.hashedPassword = "*"; # lock root account
  };
}
