{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types;

  cfg = config.modules.usrEnv;
in {
  options.modules.usrEnv = {
    desktop = mkOption {
      type = types.enum ["none" "Hyprland" "sway" "awesomewm" "i3"];
      default = "none";
      description = ''
        The desktop environment to be used.
      '';
    };

    desktops = {
      hyprland = {
        enable = mkOption {
          type = types.bool;
          default = cfg.desktop == "Hyprland";
          description = ''
            Whether to enable Hyprland wayland compositor.

            Will be enabled automatically when `modules.usrEnv.desktop` is set to "Hyprland".

          '';
        };
      };

      wallpaperService = mkOption {
        type = types.enum ["swaybg" "hyprpaper"];
        default = "swaybg";
        description = ''
          The Wallpaper service to be used.
        '';
      };
    };
  };
}
