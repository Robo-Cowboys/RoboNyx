{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.modules.roles.microvm {
    security.sudo.extraRules = [
      {
        users = ["admin"];
        commands = [
          {
            command = "ALL";
            options = ["SETENV" "NOPASSWD"];
          }
        ];
      }
    ];
  };
}
