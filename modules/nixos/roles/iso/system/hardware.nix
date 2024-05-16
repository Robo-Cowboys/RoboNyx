{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
in {
  config = mkIf config.modules.roles.iso {
    # provide all hardware drivers, including proprietary ones
    hardware = {
      enableRedistributableFirmware = true;
    };
  };
}
