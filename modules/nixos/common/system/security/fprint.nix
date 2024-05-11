{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  sys = config.my.system;
  roles = config.my.roles;
in {
  config = mkIf (sys.security.fprint.enable && roles.common) {
    # fingerprint login
    # doesn't work because thanks drivers
    services.fprintd = {
      enable = false;
      tod.enable = true;
      tod.driver = pkgs.libfprint-2-tod1-goodix;
    };

    security.pam.services = {
      login.fprintAuth = true;
      swaylock.fprintAuth = true;
    };
  };
}
