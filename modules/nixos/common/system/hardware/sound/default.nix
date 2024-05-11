{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  roles = config.my.roles;
in {
  config = mkIf (config.my.device.hasSound && roles.common) {
    sound = {
      enable = true;
      mediaKeys.enable = true;
    };
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    hardware.pulseaudio.enable = false;

    # Enable sound with pipewire.
    security.rtkit.enable = true;
  };
}
