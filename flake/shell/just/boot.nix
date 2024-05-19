{
  perSystem = _: {
    just-flake.features.boot = {
      enable = true;
      justfile = ''
        # Rebuild the system using `nh os boot`
        boot:
          nh os boot
      '';
    };
  };
}
