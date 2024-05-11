{
  lib,
  config,
  ...
}: let
  # Define a condition to check against
  condition = config.my.modules.iso;
in {
  config = lib.mkIf (!condition) {
    users.users.root.hashedPassword = "*"; # lock root account
  };
}
