{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
in {
  config = mkIf config.my.roles.iso {
    # provide all hardware drivers, including proprietary ones
    hardware = {
      enableRedistributableFirmware = true;
    };
  };
}
