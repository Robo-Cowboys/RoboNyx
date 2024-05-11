{
  config,
  lib,
  pkgs,
  ...
}: let
  sys = config.my.system;
  env = config.my.usrEnv;
  inherit (lib) mkIf;
in {
  config = mkIf sys.video.enable {
    xdg.portal = {
      enable = true;

      extraPortals = [pkgs.xdg-desktop-portal-gtk];

      config = {
        common = let
          portal =
            if env.desktop == "Hyprland"
            then "hyprland"
            else if env.desktop == "sway"
            then "wlr"
            else "gtk"; # FIXME: does this actually implement what we need?
        in {
          default = [
            "hyprland"
            "gtk"
          ];

          # for flameshot to work
          # https://github.com/flameshot-org/flameshot/issues/3363#issuecomment-1753771427
          "org.freedesktop.impl.portal.Screencast" = "${portal}";
          "org.freedesktop.impl.portal.Screenshot" = "${portal}";
        };
      };
    };
  };
}
