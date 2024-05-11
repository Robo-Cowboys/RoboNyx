{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./ignore.nix
  ];

  config = {
    programs.git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;

      userName = "use-the-fork";
      userEmail = "sincore@gmail.com";

      extraConfig = {
        init.defaultBranch = "main";
        credential.helper = "store";

        core.whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        color.ui = "auto";
      };
    };

    home.packages = [pkgs.gh];
  };
}
