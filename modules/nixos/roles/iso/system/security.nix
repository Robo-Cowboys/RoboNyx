{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.my.roles.iso {
    # attempt to fix "too many open files"
    security.pam.loginLimits = [
      {
        domain = "*";
        item = "nofile";
        type = "-";
        value = "65536";
      }
    ];
  };
}
