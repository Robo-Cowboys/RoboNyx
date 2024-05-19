{inputs', pkgs, ...}: {
  # Global nixpkgs configuration. This is ignored if nixpkgs.pkgs is set
  # which is a case that should be avoided. Everything that is set to configure
  # nixpkgs must go here.
  nixpkgs = {
    # Configuration reference:
    # <https://nixos.org/manual/nixpkgs/unstable/#chap-packageconfig>
    config = {
      allowBroken = false;
      allowUnsupportedSystem = true;

      # really a pain in the ass to deal with when disabled
      allowUnfree = true;

      # default to none, add more as necessary
      permittedInsecurePackages = [];

      # disable the usage of nixpkgs aliases in the configuration
      allowAliases = true;
    };

    overlays = [
      #TODO: Yuck.. Must be a better way to do this.
      (import ./../../../../../packages { inherit inputs'; inherit (pkgs) system; })
    ];
  };
}
