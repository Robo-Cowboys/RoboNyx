{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) my;

  sys = my.system;
  prg = sys.programs;
in {
  config = mkIf (prg.gui.enable && sys.video.enable) {
    home.packages = with pkgs; [
      networkmanagerapplet
      nordpass
      ncdu # disk space
      pamixer # pulseaudio command line mixer
      pavucontrol # pulseaudio volume controle (GUI)
      playerctl # controller for media players

      (symlinkJoin {
        # wrap obsidian with pandoc for the pandoc plugin dependency
        name = "Obsidian";
        paths = with pkgs; [
          obsidian
          pandoc # pandoc plugin uses pandoc to render alternative text formats
        ];
      })
    ];
  };
}
