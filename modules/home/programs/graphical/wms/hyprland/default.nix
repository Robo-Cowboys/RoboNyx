{
  pkgs,
  inputs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) my;
  inherit (import ./packages/packages.nix {inherit inputs pkgs;}) grimblast dbus-hyprland-env hyprpicker wrapper hyprshot;
in {
  imports = [
    ./config/binds.nix
    ./config/decorations.nix
    ./config/exec.nix
    ./config/extraConfig.nix
    ./config/general.nix
    ./config/input.nix
    ./config/layout.nix
    ./config/misc.nix
    ./config/windowrules.nix
  ];

  config = mkIf (lib.my.isWayland osConfig) {
    home.packages = [
      inputs.hyprland.packages.${pkgs.system}.hyprland
      hyprshot
      grimblast
      hyprpicker
      dbus-hyprland-env
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = wrapper;
      systemd = {
        enable = true;
        variables = ["--all"];
      };
    };
  };
}
