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

#  commitUpstream = pkgs.writeShellScript "commit-upstream" ''
#  #!/bin/bash
#
#  # Save the name of the current branch
#  current_branch=$(git rev-parse --abbrev-ref HEAD)
#
#  # Prompt user for the new branch name
#  read -p "Enter the new branch name: " new_branch
#
#  # Check if the new branch name is provided
#  if [[ -z "$new_branch" ]]; then
#    echo "No branch name provided. Exiting."
#    exit 1
#  fi
#
#  # Create and switch to the new branch
#  git checkout -b "$new_branch"
#
#  # Reset this new branch to the state of the original forked repo
#  # Replace 'upstream/master' with the appropriate branch from the forked repo
#  git reset --hard upstream/master
#
#  # Get all commits from the current branch except changes in 'systems' and 'homes' folders
#  commit_ids=$(git log $current_branch --not --grep='systems/' --grep='homes/' --pretty=format:"%H")
#
#  # Apply each commit selectively, ignoring changes in 'systems' and 'homes' directories
#  for commit_id in $commit_ids; do
#      git cherry-pick --no-commit $commit_id
#      git reset HEAD
#      git add -u
#      git add $(git status --porcelain | grep -v 'systems/' | grep -v 'homes/' | awk '{print $2}')
#      git commit -m "Cherry-picked $commit_id"
#  done
#
#  # Push the new branch to the remote repository
#  git push origin "$new_branch"
#
#  # Switch back to the original branch
#  git checkout "$current_branch"
#
#  echo "Selected changes committed to branch $new_branch, pushed to remote, and returned to $current_branch."
#
#  '';

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
    ];
  }
  // {
    inherit (pre-commit-check) shellHook;
    buildInputs = pre-commit-check.enabledPackages;
  }
