{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;

  roles = config.my.roles;
in {
  config = lib.mkIf (roles.graphical && config.my.usrEnv.desktop == "Hyprland" && roles.common) {
    # Window manager
    programs.hyprland.enable = true;
    security.pam.services.swaylock = {};
  };
}
