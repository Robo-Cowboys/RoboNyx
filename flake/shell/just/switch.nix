{
  perSystem = _: {
    just-flake.features.switch = {
      enable = true;
      justfile = ''
        # Rebuild the system using `nh os switch`
        sw:
          nh os switch
      '';
    };
  };
}
