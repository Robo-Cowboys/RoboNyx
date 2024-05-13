{
  shellCommands = [
    {
      help = "Rebuild the system using nh os switch";
      name = "sw";
      command = "nh os switch";
      category = "build";
    }
    {
      help = "Rebuild the system using nh os boot";
      name = "boot";
      command = "nh os boot";
      category = "build";
    }
    {
      help = "Build Self-made live recovery environment that overrides or/and configures certain default programs provides tools and fixes the keymaps for my keyboard.";
      name = "build-rec";
      command = ''
        mkdir -p result
        export ISO_PATH=$(nix --extra-experimental-features 'nix-command' --extra-experimental-features 'flakes' build .\#install-isoConfigurations.installer --no-link --print-out-paths -L)
        export ISO_NAME=$(nix --extra-experimental-features 'nix-command' --extra-experimental-features 'flakes' eval .\#install-isoConfigurations.installer.isoName --raw)

        cp -rv "$ISO_PATH/iso/$ISO_NAME" "result/$ISO_NAME"
      '';
      category = "build";
    }
    {
      help = "Build an air-gapped NixOS live media to deal with sensitive tooling (e.g. Yubikey, GPG, etc.) isolated from all networking";
      name = "build-air";
      command = ''
        mkdir -p result
        export ISO_PATH=$(nix --extra-experimental-features 'nix-command' --extra-experimental-features 'flakes' build .\#isoConfigurations.airgap --no-link --print-out-paths -L)
        export ISO_NAME=$(nix --extra-experimental-features 'nix-command' --extra-experimental-features 'flakes' eval .\#isoConfigurations.airgap.isoName --raw)

        cp -rv "$ISO_PATH/iso/$ISO_NAME" "result/$ISO_NAME"
      '';
      category = "build";
    }
    {
      help = "Format the source tree with treefmt";
      name = "fmt";
      command = "treefmt";
      category = "formatter";
    }
    {
      help = "Format nix files with Alejandra";
      name = "alejandra";
      package = "alejandra";
      category = "formatter";
    }
    {
      help = "Fetch source from origin";
      name = "pull";
      command = "git pull";
      category = "source control";
    }
    {
      help = "Format source tree and push commited changes to git";
      name = "push";
      command = "git push";
      category = "source control";
    }
    {
      help = "Update flake inputs and commit changes";
      name = "update";
      command = ''nix flake update && git commit flake.lock -m "flake: bump inputs"'';
      category = "utils";
    }
  ];
}
