{
  lib,
  config,
  ...
}: {
  config = {
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
