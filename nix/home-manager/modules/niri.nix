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
          
          "Mod+Q".action = close-window;

          "Mod+F".action = toggle-window-floating;

          # Navigation
          "Mod+Left".action = focus-column-left;
          "Mod+Right".action = focus-column-right;
          "Mod+Up".action = focus-window-up;
          "Mod+Down".action = focus-window-down;
          "Alt+Tab".action = focus-window-previous;

          # Workspace Navigation (Numeric)
          "Mod+1".action = focus-workspace 1;
          "Mod+2".action = focus-workspace 2;
          "Mod+3".action = focus-workspace 3;
          "Mod+4".action = focus-workspace 4;
          "Mod+5".action = focus-workspace 5;
          "Mod+6".action = focus-workspace 6;
          "Mod+7".action = focus-workspace 7;
          "Mod+8".action = focus-workspace 8;
          "Mod+9".action = focus-workspace 9;
          "Mod+0".action = focus-workspace 10;

          # Move to Workspace (Numeric)
          # "Mod+Shift+1".action = move-column-to-workspace 1;
          # "Mod+Shift+2".action = move-column-to-workspace 2;
          # "Mod+Shift+3".action = move-column-to-workspace 3;
          # "Mod+Shift+4".action = move-column-to-workspace 4;
          # "Mod+Shift+5".action = move-column-to-workspace 5;
          # "Mod+Shift+6".action = move-column-to-workspace 6;
          # "Mod+Shift+7".action = move-column-to-workspace 7;
          # "Mod+Shift+8".action = move-column-to-workspace 8;
          # "Mod+Shift+9".action = move-column-to-workspace 9;
          #"Mod+Shift+0".action = move-column-to-workspace 10;

          # Move column
          "Mod+Ctrl+Left".action = move-column-left;
          "Mod+Ctrl+Right".action = move-column-right;
          "Mod+Ctrl+Down".action = move-column-to-workspace-down;
          "Mod+Ctrl+Up".action = move-column-to-workspace-up;

          # App Launchers
          "Mod+Return".action = spawn "ghostty";
          "Mod+B".action = spawn "firefox";
          #"Alt+Space".action = spawn "pkill rofi || rofi -show drun -show-icons";
          "Alt+Space".action.spawn =  noctalia "launcher toggle";

          # Mouse & Trackpad Scroll Bindings
          "Mod+WheelScrollDown" = {
            action = focus-workspace-down;
            cooldown-ms = 50;
          };
          "Mod+WheelScrollUp" = {
            action = focus-workspace-up;
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

          # Multimedia & Hardware Controls
          "XF86AudioRaiseVolume" = {
            action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+";
            allow-when-locked = true;
          };
          "XF86AudioLowerVolume" = {
            action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-";
            allow-when-locked = true;
          };
          "XF86AudioMute" = {
            action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
            allow-when-locked = true;
          };
          "XF86AudioMicMute" = {
            action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
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
            action = spawn "playerctl" "play-pause";
            allow-when-locked = true;
          };
          "XF86AudioNext" = {
            action = spawn "playerctl" "next";
            allow-when-locked = true;
          };
          "XF86AudioPrev" = {
            action = spawn "playerctl" "previous";
            allow-when-locked = true;
          };

          # Overview
          "Mod+Tab" = {
            action = toggle-overview;
            repeat = false;
          };
        };
        
        layout = {

          gaps = 8;

          center-focused-column = "on-overflow";

          always-center-single-column = true;

          background-color = "transparent";

          preset-column-widths = [
            { proportion = 1. / 3.; }
            { proportion = 1. / 2.; }
            { proportion = 2. / 3.; }
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
          QT_QPA_PLATFORMTHEME = "qtct";
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

        spawn-at-startup = [
          { command = [ "xwayland-satellite" ]; }
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
    

#   programs.niri.enable = true;
    
#   programs.niri.settings = {
#   input.keyboard.xkb.layout = "no";
#   input.mouse.accel-speed = 1.0;
#   input.touchpad = {
#     tap = true;
#     dwt = true;
#     natural-scroll = true;
#     click-method = "clickfinger";
#   };

#   input.tablet.map-to-output = "eDP-1";
#   input.touch.map-to-output = "eDP-1";

#   prefer-no-csd = true;

#   layout = {
#     gaps = 16;
#     struts.left = 64;
#     struts.right = 64;
#     border.width = 4;
#     always-center-single-column = true;

#     empty-workspace-above-first = true;

#     # fog of war
#     focus-ring = {
#       # enable = true;
#       width = 10000;
#       active.color = "#00000055";
#     };
#     # border.active.gradient = {
#     #   from = "red";
#     #   to = "blue";
#     #   in' = "oklch shorter hue";
#     # };

#     shadow.enable = true;

#     # default-column-display = "tabbed";

#     tab-indicator = {
#       position = "top";
#       gaps-between-tabs = 10;

#       # hide-when-single-tab = true;
#       # place-within-column = true;

#       # active.color = "red";
#     };
#   };
# };
}