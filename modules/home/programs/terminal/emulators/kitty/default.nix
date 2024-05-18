{
  osConfig,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;
  inherit (modules.style.colorScheme) colors;

  dev = modules.device;
  acceptedTypes = ["laptop" "desktop" "hybrid"];
in {
  config = mkIf (builtins.elem dev.type acceptedTypes) {
    programs.kitty = {
      enable = true;

      settings = import ./settings.nix {inherit colors;};

      keybindings = {
        ## Tabs
        "alt+1" = "goto_tab 1";
        "alt+2" = "goto_tab 2";
        "alt+3" = "goto_tab 3";
        "alt+4" = "goto_tab 4";

        ## Unbind
        "ctrl+shift+left" = "no_op";
        "ctrl+shift+right" = "no_op";
      };
    };
  };
}
