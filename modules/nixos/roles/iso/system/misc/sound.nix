{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf mkForce;
in {
  config = mkIf config.my.modules.iso {
    # disable sound related programs
    sound.enable = mkForce false;
  };
}
