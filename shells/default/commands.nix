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
      help = "Cherrypick changes and push them to 'upstream' branch.";
      name = "upstream";
      command = ''
        # Add upstream repository if not already added
        if ! git remote | grep -q upstream; then
            git remote add upstream https://github.com/Spacebar-Cowboys/nyx.git
        fi

        # Fetch the latest changes from the upstream repository
        git fetch upstream

        # Checkout the main branch from your fork and update it
        git checkout main
        git pull origin main

        # Create or checkout nyx-upstream and reset it to match the upstream main branch
        git checkout -b nyx-upstream 2>/dev/null || git checkout nyx-upstream
        git reset --hard upstream/main

        # List commits in your fork's main that are not in the upstream main
        # Exclude certain paths by filtering commits after generating the list
        commits_to_cherry_pick=$(git log --format=%H main --not upstream/main | while read commit_hash; do
            if [ -z "$(git diff --name-only $commit_hash^..$commit_hash | grep -E '^(homes/|systems/x86_64-linux/)')" ]; then
                echo $commit_hash
            fi
        done)

        # Cherry-pick these commits into the new branch
        echo "$commits_to_cherry_pick" | while IFS= read -r commit_hash; do
          git cherry-pick $commit_hash || {
            # If cherry-pick fails, handle the conflict
            echo "Cherry-pick conflict on commit $commit_hash, attempting to continue..."
            git cherry-pick --continue || {
              echo "Failed to continue cherry-picking, aborting..."
              git cherry-pick --abort
              break
            }
          }
        done

        git push origin nyx-upstream --force
      '';
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
