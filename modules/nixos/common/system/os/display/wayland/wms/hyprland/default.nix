{
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.my.modules.graphical && config.my.usrEnv.desktop == "Hyprland") {
    # Window manager
    programs.hyprland.enable = true;
    security.pam.services.swaylock = {};
  };
}
