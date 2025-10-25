{config, pkgs, ...}:
let
  # Define a helper function to wrap noctalia commands
  noctalia = cmd: [
    "noctalia-shell" "ipc" "call"
  ] ++ pkgs.lib.splitString " " cmd;
in
{ 

  #stylix.targets.niri.enable = true;
  
  programs.niri = {
    settings = {

      binds = with config.lib.niri.actions; {
      
        # Navigation
        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;
        "Mod+Up".action = focus-window-or-workspace-up;
        "Mod+Down".action = focus-window-or-workspace-down;
        "Alt+Tab".action = focus-window-previous;

        # Size adjusting
        "Mod+Shift+Left".action = set-column-width "-10%";
        "Mod+Shift+Right".action = set-column-width "+10%";
        "Mod+Shift+Up".action = set-window-height "-10%";
        "Mod+Shift+Down".action = set-window-height "+10%";

        # Workspace Navigation (Numeric)
        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+A".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;
        "Mod+0".action = focus-workspace 10;

        # Move to Workspace (Numeric)
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+A".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;
        "Mod+Shift+0".action.move-column-to-workspace = 10;

        # Move column
        "Mod+Ctrl+Left".action = move-column-left;
        "Mod+Ctrl+Right".action = move-column-right;
        "Mod+Ctrl+Down".action = move-window-down-or-to-workspace-down;
        "Mod+Ctrl+Up".action = move-window-up-or-to-workspace-up;

        # Unify or expel columns with each other
        "Mod+BracketLeft".action = consume-or-expel-window-left;
        "Mod+bracketRight".action = consume-or-expel-window-right;  

        "Mod+R".action = switch-preset-column-width;

        "Mod+Shift+R".action = switch-preset-window-height;      
        
        "Mod+Ctrl+R".action = reset-window-height;

        "Mod+Shift+F".action = maximize-column; 

        "Mod+Ctrl+F".action = fullscreen-window;

        "Mod+C".action = center-column;

        # Center all fully visible columns on screen.
        "Mod+Ctrl+C".action = center-visible-columns;
        
        "Mod+W".action = toggle-column-tabbed-display;

        # Colum operations
        "Mod+Q" = {
          action = close-window;
          repeat = false;
        };
        "Mod+F".action = toggle-window-floating;
        "Mod+Tab" = {
          action = toggle-overview;
          repeat = false;
        };

        # App Launchers
        "Mod+Return".action = spawn "ghostty";
        "Mod+B".action = spawn "firefox";
        "Mod+E".action = spawn "dolphin";

        "Alt+Space".action.spawn =  noctalia "launcher toggle";
        "XF86Search".action.spawn = noctalia "launcher toggle";
        "Mod+Period".action = spawn "Emoji Selector";

        #"XF86Calculator".action = spawn ""; to be added

        # Screen capture
        "Print".action.screenshot-window = [];
        "Mod+Shift+S".action.screenshot = [];

        # Mouse & Trackpad Scroll Bindings
        "Mod+WheelScrollDown" = {
          action = focus-workspace-down;
          cooldown-ms = 50;
        };
        "Mod+WheelScrollUp" = {
          action = focus-workspace-up;
          cooldown-ms = 50;
        };
        "Mod+Shift+WheelScrollDown" = {
          action = focus-column-right;
          cooldown-ms = 50;
        };
        "Mod+Shift+WheelScrollUp" = {
          action = focus-column-left;
          cooldown-ms = 50;
        };
        "Mod+WheelScrollRight" = {
          action = focus-column-right;
          cooldown-ms = 100;
        };
        "Mod+WheelScrollLeft" = {
          action = focus-column-left;
          cooldown-ms = 100;
        };

        # Multimedia & Hardware Controls - need to change to noctalia
        "XF86AudioRaiseVolume" = {
          action.spawn = noctalia "volume increase";
          allow-when-locked = true;
        };
        "XF86AudioLowerVolume" = {
          action.spawn = noctalia "volume decrease";
          allow-when-locked = true;
        };
        "XF86AudioMute" = {
          action.spawn = noctalia "volume muteOutput";
          allow-when-locked = true;
        };
        "XF86AudioMicMute" = {
          action.spawn = noctalia "volume muteInput";
          allow-when-locked = true;
        };
        "XF86MonBrightnessUp" = {
          action = spawn "brightnessctl" "set" "+5%";
          allow-when-locked = true;
        };
        "XF86MonBrightnessDown" = {
          action = spawn "brightnessctl" "set" "5%-";
          allow-when-locked = true;
        };
        "XF86AudioPlay" = {
          action.spawn = noctalia "media playPause";
          allow-when-locked = true;
        };
        "XF86AudioNext" = {
          action.spawn = noctalia "media next";
          allow-when-locked = true;
        };
        "XF86AudioPrev" = {
          action.spawn = noctalia "media previous";
          allow-when-locked = true;
        };
        "Mod+Shift+B".action.spawn = noctalia "batteryManager cycle";
        #"Mod".action.spwan = noctalia "controlCenter toggle"; # At the moment niri doesn't support release key
        
        # Misc
        "Mod+L".action.spawn = noctalia "lockScreen lock";
        "Mod+Shift+P".action.spawn = noctalia "darkMode toggle";
        "Mod+Shift+Slash" = {
          action.spawn = show-hotkey-overlay;
          hotkey-overlay = [
            { title = "Show this help"; }
          ];
        };
        "Ctrl+Alt+Delete".action = quit;
      };
      
      layout = {

        gaps = 8;

        center-focused-column = "never";
        always-center-single-column = true;

        background-color = "transparent";

        preset-column-widths = [
          { proportion = 1. / 3.; }
          { proportion = 1. / 2.; }
          { proportion = 2. / 3.; }
        ];

        preset-window-heights = [
          { proportion = 1. / 3.; }
          { proportion = 1. / 2.; }
          { proportion = 2. / 3.; }
          { proportion = 1; }

          # { fixed = 1080; }
        ];



        # To decide if the border is realy necessary as focus-ring is the normal behaviour
        focus-ring = {
          enable = true;
          width = 4;
          active.color = "#7fc8ff";
          inactive.color = "#505050";
          urgent.color = "#9b0000";
        };

        #The border is a decoration drawn inside every window in the layout. It will take space away from windows. That is, if you have a border of 8px, then each window will be 8px smaller on each edge than if you had no border.
        #The currently focused window, i.e. the window that can receive keyboard input, will be drawn according to layout.border.active, and all other windows will be drawn according to layout.border.inactive.
        border = {
          enable = true;
          width = 4;
          active.color = "#7fc8ff";
          inactive.color = "#505050";
          urgent.color = "#9b0000";
        };

        shadow = {
          enable = true;
          color = "#00000070";
          draw-behind-window = false; #Default don't know if needed
          inactive-color = "#00000070"; # Can be removed
          offset.x = 0.000000; # Default
          offset.y = 5.000000; # Default
          softness = 30.000000; # Default
          spread = 5.000000; # Default

        };

        # Don't know what this does
        tab-indicator = {
          enable = true;
          corner-radius = 0.000000; # Default
          gap = 5.000000; # Default
          gaps-between-tabs = 0.000000; # Default
          hide-when-single-tab = false; # Default
          length.total-proportion = 0.500000; # Default
          place-within-column = false; # Default
          position = "top";
          width = 4.000000; # Default
          # active, inactive and urgent colors
        };

      };

      prefer-no-csd = true;

      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
      
      input = { 
        keyboard.xkb.layout = "eu, pt";
        keyboard.numlock = true;
        keyboard.xkb.options = "grp:alt_caps_toggle";

        touchpad = {
          dwt = true;
          dwtp = true;
          tap = true;
          middle-emulation = true;
          drag = true;
        };

        mouse = {
          middle-emulation = true;
        };

        focus-follows-mouse.enable = true;

        workspace-auto-back-and-forth = true;
      };

      cursor = {
        theme = "breeze"; # Maybe change maybe not
        size = 24;
        hide-after-inactive-ms = 20000;
        hide-when-typing = false;

      };

      environment = {
        DISPLAY = ":0";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        NIXOS_OZONE_WL = "1";
        CLUTTER_BACKEND = "wayland";
        GDK_BACKEND = "wayland";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        QT_QPA_PLATFORM = "wayland";
        #QT_QPA_PLATFORMTHEME = "qtct";
        #QT_STYLE_OVERRIDE = "kvantum";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      };

      workspaces."1" = {
        name = "1";
        # open-on-output is an option but needs multi-screen testing
        };
      workspaces."2" = { name = "2"; };
      workspaces."3" = { name = "3"; };
      workspaces."Chats" = { name = "Chats"; };
      workspaces."Misc" = { name = "Misc"; };

      window-rules = [
        {
          matches = [
            {
              app-id = "^KeePassXC$";
            }
          ];
          open-on-workspace = "Misc";  
          
        }
      ];

      # animations {
      #   workspace-switch {
      #       spring damping-ratio=0.80 stiffness=523 epsilon=0.0001
      #   }
      #   window-open {
      #       duration-ms 150
      #       curve "ease-out-expo"
      #   }
      #   window-close {
      #       duration-ms 150
      #       curve "ease-out-quad"
      #   }
      #   horizontal-view-movement {
      #       spring damping-ratio=0.85 stiffness=423 epsilon=0.0001
      #   }
      #   window-movement {
      #       spring damping-ratio=0.75 stiffness=323 epsilon=0.0001
      #   }
      #   window-resize {
      #       spring damping-ratio=0.85 stiffness=423 epsilon=0.0001
      #   }
      #   config-notification-open-close {
      #       spring damping-ratio=0.65 stiffness=923 epsilon=0.001
      #   }
      #   screenshot-ui-open {
      #       duration-ms 200
      #       curve "ease-out-quad"
      #   }
      #   overview-open-close {
      #       spring damping-ratio=0.85 stiffness=800 epsilon=0.0001
      #   }
      # }


      spawn-at-startup = [
        { command = [ "noctalia-shell" ]; }
        
        # {
        # command = [
        #   "sh"
        #   "-c"
        #   "~/.local/bin/fuzzel-polkit.sh"
        # ];
        # }
      ];
    };
  };
    
  # XWayland satellite service for X11 app support
  systemd.user.services.xwayland-satellite = {
    Unit = {
      Description = "Xwayland outside Wayland";
      BindsTo = "graphical-session.target";
      After = "graphical-session.target";
    };
    Service = {
      Type = "notify";
      NotifyAccess = "all";
      ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
      StandardOutput = "journal";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

}