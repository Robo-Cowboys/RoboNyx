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
      help = "Push changes to upstream";
      name = "upstream";
      command = ''

                  # Save the name of the current branch
                  current_branch=$(git rev-parse --abbrev-ref HEAD)

                  # Prompt user for the new branch name
                  read -p "Enter the new branch name: " new_branch

                  # Check if the new branch name is provided
                  if [[ -z "$new_branch" ]]; then
                    echo "No branch name provided. Exiting."
                    exit 1
                  fi

                  # Create and switch to the new branch
                  git checkout -b "$new_branch"

                  # Reset this new branch to the state of the original forked repo
                  # Replace 'upstream/master' with the appropriate branch from the forked repo
                  git reset --hard upstream/master

                  # Get all commits from the current branch except changes in 'systems' and 'homes' folders
                  commit_ids=$(git log $current_branch --not --grep='systems/' --grep='homes/' --pretty=format:"%H")

                  # Apply each commit selectively, ignoring changes in 'systems' and 'homes' directories
                  for commit_id in $commit_ids; do
                      git cherry-pick --no-commit $commit_id
                      git reset HEAD
                      git add -u
                      git add $(git status --porcelain | grep -v 'systems/' | grep -v 'homes/' | awk '{print $2}')
                      git commit -m "Cherry-picked $commit_id"
                  done

                  # Push the new branch to the remote repository
                  git push origin "$new_branch"

                  # Switch back to the original branch
                  git checkout "$current_branch"

                  echo "Selected changes committed to branch $new_branch, pushed to remote, and returned to $current_branch."

                  '';
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
