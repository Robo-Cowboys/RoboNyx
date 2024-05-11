{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.my) roles;
in {
  config = mkIf roles.laptop {
    services = {
      # Input settings for libinput
      xserver.libinput = {
        # enable libinput
        enable = true;

        # disable mouse acceleration
        mouse = {
          accelProfile = "flat";
          accelSpeed = "0";
          middleEmulation = false;
        };

        # touchpad settings
        touchpad = {
          naturalScrolling = true;
          tapping = true;
          clickMethod = "clickfinger";
          horizontalScrolling = false;
          disableWhileTyping = true;
        };
      };
    };
  };
}
