{ inputs, config, pkgs, lib, system, ... }: {
  imports = [
           inputs.treefmt-nix.flakeModule
            inputs.just-flake.flakeModule
            inputs.pre-commit-hooks-nix.flakeModule
  ];

  perSystem = {pkgs, config, ...}: {
          just-flake.features = {
            treefmt.enable = true;
            convco.enable = true;
          };

          # Add your auto-formatters here.
          # cf. https://numtide.github.io/treefmt/
          treefmt.config = {
            projectRootFile = "flake.nix";
            flakeCheck = false; # pre-commit-hooks.nix checks this
            programs = {
              nixpkgs-fmt.enable = true;
            };
          };

          pre-commit = {
            check.enable = true;
            settings = {
              hooks = {
                treefmt.enable = true;
                convco.enable = true;
              };
            };
          };

          devShells.default = pkgs.mkShell {
            inputsFrom = [
              config.treefmt.build.devShell
              config.just-flake.outputs.devShell
              config.pre-commit.devShell
            ];
            packages = [
              config.pre-commit.settings.tools.convco
            ];
          };
  };
}
