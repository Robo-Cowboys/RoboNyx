{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.strings) concatStringsSep;
  inherit (lib.meta) getExe;

  env = config.modules.usrEnv;
  sys = config.modules.system;

  # make desktop session paths available to greetd
  sessionData = config.services.displayManager.sessionData.desktops;
  sessionPaths = concatStringsSep ":" [
    "${sessionData}/share/xsessions"
    "${sessionData}/share/wayland-sessions"
  ];

  initialSession = {
    user = "${sys.mainUser}";
    command = "${env.desktop}";
  };

  defaultSession = {
    user = "greeter";
    command = concatStringsSep " " [
      (getExe pkgs.greetd.tuigreet)
      "--time"
      "--remember"
      "--remember-user-session"
      "--asterisks"
      "--sessions '${sessionPaths}'"
    ];
  };
in {
  config = {
    services.greetd = {
      enable = true;
      vt = 2;
      restart = !sys.autoLogin;

      # <https://man.sr.ht/~kennylevinsen/greetd/>
      settings = {
        # default session is what will be used if no session is selected
        # in this case it'll be a TUI greeter
        default_session = defaultSession;

        # initial session
        initial_session = mkIf sys.autoLogin initialSession;
      };
    };
  };
}
