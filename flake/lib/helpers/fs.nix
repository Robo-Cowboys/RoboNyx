{
  lib,
  self,
  ...
}: let
  inherit (self) globals;
in {
  fs = rec {
    ## Matchers for file kinds. These are often used with `readDir`.
    ## Example Usage:
    ## ```nix
    ## is-file-kind "directory"
    ## ```
    ## Result:
    ## ```nix
    ## false
    ## ```
    #@ String -> Bool
    is-file-kind = kind: kind == "regular";
    is-symlink-kind = kind: kind == "symlink";
    is-directory-kind = kind: kind == "directory";
    is-unknown-kind = kind: kind == "unknown";

    ## Get a file path relative to the user's flake.
    ## Example Usage:
    ## ```nix
    ## get-file "systems"
    ## ```
    ## Result:
    ## ```nix
    ## "/user-source/systems"
    ## ```
    #@ Path -> Path
    get-file = path: "${globals.flakeRoot}/${path}";
  };

  getSecretFile = file: "${globals.flakeRoot}/secrets/${file}";
  #  getSSHKeyFiles = user:
  #    fs.get-files (fs.get-file "keys/${user}/ssh");
}
