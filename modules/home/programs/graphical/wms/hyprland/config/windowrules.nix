{
  config = {
    wayland.windowManager.hyprland.settings = {
      windowrulev2 = [
        # only allow shadows for floating windows
        "noshadow, floating:0"

        "float,class:udiskie"

        # NordPass
        "float,class:NordPass"

        "idleinhibit focus,class:kitty"

        # firefox
        "idleinhibit fullscreen, class:^(firefox)$"
        "float,title:^(Firefox — Sharing Indicator)$"
        "move 0 0,title:^(Firefox — Sharing Indicator)$"
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "opacity 1.0 override 1.0 override, title:^(Picture-in-Picture)$"

        # pavucontrol
        "float,class:pavucontrol"
        "float,title:^(Volume Control)$"
        "size 800 600,title:^(Volume Control)$"
        "move 75 44%,title:^(Volume Control)$"
        "float, class:^(imv)$"
        "opacity 1.0 override 1.0 override, title:^(.*imv.*)$"
        "opacity 1.0 override 1.0 override, title:^(.*mpv.*)$"
        "opacity 1.0 override 1.0 override, class:(Aseprite)"
        "opacity 1.0 override 1.0 override, class:(Unity)"
        "idleinhibit focus, class:^(mpv)$"
        "idleinhibit fullscreen, class:^(chrome)$"

        "rounding 0, xwayland:1"

        "workspace 6 silent, class:^(signal)$"

        # JetBrains - Enhanced rules
        "nofocus,class:^jetbrains-(?!toolbox),floating:1,title:^win\d+$"
        # search dialog
        "dimaround,class:^(jetbrains-.*)$,floating:1,title:^(?!win)"
        "center,class:^(jetbrains-.*)$,floating:1,title:^(?!win)"

        # autocomplete & menus
        "noanim,class:^(jetbrains-.*)$,title:^(win.*)$"
        "noinitialfocus,class:^(jetbrains-.*)$,title:^(win.*)$"
        "rounding 0,class:^(jetbrains-.*)$,title:^(win.*)$"

      ];
    };
  };
}
