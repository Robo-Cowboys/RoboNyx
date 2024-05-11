{
  osConfig,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) my;

  prg = my.system.programs;
in {
  config = mkIf prg.cli.enable {
    home.packages = with pkgs; [
      # CLI packages from nixpkgs
      catimg
      duf
      todo
      hyperfine
      fzf
      file
      unzip
      ripgrep
      rsync
      fd
      jq
      figlet
      lm_sensors
      dconf
      nitch
      skim
      p7zip
      btop
    ];
  };
}
