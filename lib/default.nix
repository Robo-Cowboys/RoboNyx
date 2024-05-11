{lib, ...}: let
  inherit (import ./helpers/fs.nix {inherit lib;}) getSecretFile getSharedModule getSSHKeyFiles;
  inherit (import ./helpers/types.nix {inherit lib;}) boolToNum;
  inherit (import ./helpers/themes.nix {inherit lib;}) serializeTheme compileSCSS;
  inherit (import ./services.nix {inherit lib;}) mkGraphicalService mkHyprlandService;
  inherit (import ./validators.nix {inherit lib;}) ifTheyExist ifGroupsExist isAcceptedDevice isWayland ifOneEnabled;
in {
  inherit getSecretFile getSharedModule getSSHKeyFiles;
  inherit boolToNum;
  inherit serializeTheme compileSCSS;
  inherit mkGraphicalService mkHyprlandService;
  inherit ifTheyExist ifGroupsExist isAcceptedDevice isWayland ifOneEnabled;

  theme = {
    font = "Ubuntu Nerd Font Light";
    accent = "blue";
    name = "Catppuccin-Mocha-Compact-Blue-Dark";
    flavor = "mocha"; # One of `latte`, `frappe`, `macchiato`, or `mocha`
    wallpaper = ./../wallpaper/nix-black-4k.png;

    colors = let
      baseColors = {
        rosewater = "f5e0dc";
        flamingo = "f2cdcd";
        pink = "f5c2e7";
        mauve = "cba6f7";
        red = "f38ba8";
        maroon = "eba0ac";
        peach = "fab387";
        yellow = "f9e2af";
        green = "a6e3a1";
        teal = "94e2d5";
        sky = "89dceb";
        sapphire = "74c7ec";
        blue = "89b4fa";
        lavender = "b4befe";
        text = "cdd6f4";
        subtext1 = "bac2de";
        subtext0 = "a6adc8";
        overlay2 = "9399b2";
        overlay1 = "7f849c";
        overlay0 = "6c7086";
        surface2 = "585b70";
        surface1 = "45475a";
        surface0 = "313244";
        base = "1e1e2e";
        mantle = "181825";
        crust = "11111b";
      };
    in rec {
      inherit (baseColors) rosewater flamingo pink mauve red maroon peach yellow green teal sky sapphire blue lavender text subtext1 subtext0 overlay2 overlay1 overlay0 surface2 surface1 surface0 base mantle crust;

      withHashtag = lib.mapAttrs (_: value: "#" + value) baseColors;
    };
  };

  package-helper = {
    pins = import ./../npins;
    propegateInputs = package: deps:
      package.overrideAttrs (old: {
        propagatedBuildInputs =
          deps
          ++ lib.optionals (builtins.hasAttr "propagatedBuildInputs" old)
          old.propagatedBuildInputs;
      });
  };

  stateVersion = {
    nixos = "23.11";
    # This should be the same as nixos
    home = "23.11";
    darwin = 4;
  };
}
