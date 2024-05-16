{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.modules.roles.headless {
    # a headless system shoudld not mount any removable media
    # without explicit user action
    services.udisks2.enable = false;
  };
}
