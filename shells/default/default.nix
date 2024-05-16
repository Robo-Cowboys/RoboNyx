{
  lib,
  pkgs,
  inputs,
  system,
  ...
}: let
  pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
    src = ./.;
    hooks = {
      deadnix.enable = true;
      alejandra.enable = true;
      statix.enable = true;
      actionlint.enable = true;
    };
  };

  extra = import ./commands.nix;
in
  inputs.devshell.legacyPackages."${system}".mkShell {
    name = "dotfiles";
    commands = extra.shellCommands;
    env = [
      {
        # make direnv shut up
        name = "DIRENV_LOG_FORMAT";
        value = "";
      }
    ];
    #buildInputs = pre-commit-check.enabledPackages;
    packages = with pkgs; [
      nix-prefetch-git
      cachix
      #                                                                  inputs'.agenix.packages.default # provide agenix CLI within flake shell
      #                                                                  inputs'.catppuccinifier.packages.cli
      nil # nix ls
      # Formatting
      treefmt
      taplo
      deadnix
      statix
      #      alejandra
      nodePackages.prettier
      python310Packages.mdformat
      shfmt
      # some python stuff for waybar scripting
      #testing if upstream works.
    ];
  }
  // {
    inherit (pre-commit-check) shellHook;
    buildInputs = pre-commit-check.enabledPackages;
  }
