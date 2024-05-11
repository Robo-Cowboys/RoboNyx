{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf config.my.modules.iso {
    # the ISO image must be completely immutable in the sense that we do not
    # want the user to be able modify the ISO image after booting into it
    # the below option will disable rebuild switches (i.e nixos-rebuild switch)
    system.switch.enable = false;
  };
}
