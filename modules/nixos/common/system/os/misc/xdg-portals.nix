{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  sys = config.my.system;
  roles = config.my.roles;
in {
  config = mkIf (sys.video.enable && roles.common) {
    xdg.portal.config = {
      common = {
        "org.freedesktop.impl.portal.Secret" = [
          "gnome-keyring"
        ];
      };
    };
  };
}
