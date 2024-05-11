{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  roles = config.my.roles;
in {
  config = mkIf roles.common {
    time = {
      timeZone = "America/New_York";
      hardwareClockInLocalTime = true;
    };

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    i18n.defaultLocale = "en_US.UTF-8";
  };
}
