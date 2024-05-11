{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.types) isType;
  inherit (lib.attrsets) filterAttrs mapAttrs;
  inherit (lib.modules) mkDefault;
in {
  system = {
    autoUpgrade.enable = false;
  };

  environment = {
    etc =
      lib.mapAttrs'
      (name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
      })
      config.nix.registry;

    # we need git for flakes, don't we
    systemPackages = [pkgs.git];
  };

  # faster rebuilding
  documentation = {
    doc.enable = false;
    info.enable = false;

    # <https://mastodon.online/@nomeata/109915786344697931>
    # I need this enabled for the anyrun-nixos-options plugin
    # but otherwise, it should be disabled to avoid unnecessary rebuilds
    nixos.enable = true;

    # manpages
    man = {
      enable = mkDefault true;
      generateCaches = mkDefault true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);
    nixPath = ["/etc/nix/path"];

    # automatically optimize nix store my removing hard links
    # do it after the gc
    optimise = {
      automatic = true;
      dates = ["04:00"];
    };

    settings = {
      # tell nix to use the xdg spec for base directories
      # while transitioning, any state must be carried over
      # manually, as Nix won't do it for us
      use-xdg-base-directories = true;

      # specify the path to the nix registry
      flake-registry = "/etc/nix/registry.json";

      # Free up to 10GiB whenever there is less than 5GB left.
      # this setting is in bytes, so we multiply with 1024 thrice
      min-free = "${toString (5 * 1024 * 1024 * 1024)}";
      max-free = "${toString (10 * 1024 * 1024 * 1024)}";

      # automatically optimise symlinks
      auto-optimise-store = true;

      # allow sudo users to mark the following values as trusted
      allowed-users = ["root" "@wheel" "nix-builder"];

      # only allow sudo users to manage the nix store
      trusted-users = ["root" "@wheel" "nix-builder"];

      # let the system decide the number of max jobs
      max-jobs = "auto";

      # build inside sandboxed environments
      #      sandbox = true;
      #      sandbox-fallback = false;

      # supported system features
      system-features = ["nixos-test" "kvm" "recursive-nix" "big-parallel"];

      # extra architectures supported by my builders
      #      extra-platforms = config.boot.binfmt.emulatedSystems;

      # continue building derivations if one fails
      #      keep-going = true;

      # bail early on missing cache hits
      connect-timeout = 5;

      # show more log lines for failed builds
      log-lines = 30;

      # enable new nix command and flakes
      # and also "unintended" recursion as well as content addressed nix
      extra-experimental-features = [
        "flakes" # flakes
        "nix-command" # experimental nix commands
        "recursive-nix" # let nix invoke itself
        "ca-derivations" # content addressed nix
        "auto-allocate-uids" # allow nix to automatically pick UIDs, rather than creating nixbld* user accounts
        "configurable-impure-env" # allow impure environments
        "cgroups" # allow nix to execute builds inside cgroups
        "git-hashing" # allow store objects which are hashed via Git's hashing algorithm
        "verified-fetches" # enable verification of git commit signatures for fetchGit
      ];

      # don't warn me that my git tree is dirty, I know
      warn-dirty = false;

      # maximum number of parallel TCP connections used to fetch imports and binary caches, 0 means no limit
      http-connections = 50;

      # whether to accept nix configuration from a flake without prompting
      accept-flake-config = false;

      # execute builds inside cgroups
      #      use-cgroups = true;

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;
    };
  };
}
