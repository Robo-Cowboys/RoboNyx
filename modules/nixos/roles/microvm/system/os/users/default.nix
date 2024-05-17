{
  config,
  lib,
  ...
}: {
  config = {
    users.users.admin = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      openssh.authorizedKeys.keys = [];
    };
  };
}
