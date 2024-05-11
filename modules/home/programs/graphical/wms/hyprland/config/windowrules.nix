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
        #      "float,class:^(pavucontrol)$"
        #      "float,class:^(SoundWireServer)$"
        #      "float,class:^(file_progress)$"
        #      "float,class:^(confirm)$"
        #      "float,class:^(dialog)$"
        #      "float,class^(download)$"
        #      "float,class^(notification)$"
        #      "float,class:^(error)$"
        #      "float,class:^(confirmreset)$"
        "float,title:^(Open File)$"
        "float,title:^(Open Project)$"
        #      "float,title:^(branchdialog)$"
        "float,title:^(Confirm to replace files)$"
        "float,title:^(File Operation Progress)$"
        "rounding 0, xwayland:1"

        "workspace 6 silent, class:^(signal)$"

        # JetBrains - Enhanced rules
        #        "center, class:^(.*jetbrains.*)$, title:^(Confirm|Open|win424|win201|splash|Settings)$"
        #        "size 640 400, class:^(.*jetbrains.*)$, title:^(splash)$"
        #      "center,class:^(.*jetbrains.*)$, title:^(.*popup.*|.*dialog.*|.*modal.*)$"

        # -- Fix odd behaviors in IntelliJ IDEs --
        "windowdance,class:^(jetbrains-.*)$,floating:1"

        #! Fix splash screen showing in weird places and prevent annoying focus takeovers
        "center,class:^(jetbrains-.*)$,title:^(splash)$,floating:1"
        "nofocus,class:^(jetbrains-.*)$,title:^(splash)$,floating:1"
        "noborder,class:^(jetbrains-.*)$,title:^(splash)$,floating:1"

        #! Center popups/find windows
        "center,class:^(jetbrains-.*)$,title:^( )$,floating:1"
        "stayfocused,class:^(jetbrains-.*)$,title:^( )$,floating:1"
        "noborder,class:^(jetbrains-.*)$,title:^( )$,floating:1"

        #! Disable window flicker when autocomplete or tooltips appear
        "nofocus,class:^(jetbrains-.*)$,title:^(win.*)$,floating:1"

        #      "workspace 4 silent, class:^(.*jetbrains.*)$" # Allocating a specific workspace for JetBrains
        #      "fullscreen allowed, class:^(.*jetbrains.*)$" # Allow fullscreen mode for better focus on coding
        #      "sticky, class:^(.*jetbrains.*)$, title:^(task.*|tool.*)$" # Make task and tool windows sticky across workspaces
      ];
    };
  };
}
