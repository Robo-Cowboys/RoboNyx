{...}: {
  imports = [
    ./modules/device.nix
    ./modules/profiles.nix
    ./modules/system.nix
    ./modules/modules.nix
    ./modules/usrEnv.nix
    ./modules/style.nix
    ./fs/disko.nix
    ./hardware-configuration.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.sincore = {};
  };

  networking.hostName = "sushi"; # Define your hostname.
}
