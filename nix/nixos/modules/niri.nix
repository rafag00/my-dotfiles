{ pkgs, lib, config, ... }: {
  # enable the binary cache on all systems; useful for remote build
    options = {
        niri.enable = lib.mkEnableOption "Niri, a Wayland compositor";
    };
  
  config = lib.mkIf config.niri.enable {
    

    programs.niri.enable = true;
    niri-flake.cache.enable = true;
    programs.niri.package = pkgs.niri-stable;
    environment.variables.NIXOS_OZONE_WL = "1";
    environment.systemPackages = with pkgs; [
        # wl-clipboard
        # wayland-utils
        # libsecret
        # cage
        # gamescope
        # xwayland-satellite-unstable
    ];
    #   home-shortcut.imports = [
    #     (
    #         programs.niri.settings = {
    #           input.keyboard.xkb.layout = "no";
    #           input.mouse.accel-speed = 1.0;
    #           input.touchpad = {
    #             tap = true;
    #             dwt = true;
    #             natural-scroll = true;
    #             click-method = "clickfinger";
    #           };

    #           input.tablet.map-to-output = "eDP-1";
    #           input.touch.map-to-output = "eDP-1";

    #           prefer-no-csd = true;

    #           layout = {
    #             gaps = 16;
    #             struts.left = 64;
    #             struts.right = 64;
    #             border.width = 4;
    #             always-center-single-column = true;

    #             empty-workspace-above-first = true;

    #             # fog of war
    #             focus-ring = {
    #               # enable = true;
    #               width = 10000;
    #               active.color = "#00000055";
    #             };
    #             # border.active.gradient = {
    #             #   from = "red";
    #             #   to = "blue";
    #             #   in' = "oklch shorter hue";
    #             # };

    #             shadow.enable = true;

    #             # default-column-display = "tabbed";

    #             tab-indicator = {
    #               position = "top";
    #               gaps-between-tabs = 10;

    #               # hide-when-single-tab = true;
    #               # place-within-column = true;

    #               # active.color = "red";
    #             };
    #           };

    #           hotkey-overlay.skip-at-startup = !nixosConfig.is-virtual-machine;
    #           clipboard.disable-primary = true;

    #           overview.zoom = 0.5;

    #           screenshot-path = "~/Pictures/Screenshots/%Y-%m-%dT%H:%M:%S.png";

    #           switch-events =
    #             with config.lib.niri.actions;
    #             let
    #               sh = spawn "sh" "-c";
    #             in
    #             {
    #               tablet-mode-on.action = sh "notify-send tablet-mode-on";
    #               tablet-mode-off.action = sh "notify-send tablet-mode-off";
    #               lid-open.action = sh "notify-send lid-open";
    #               lid-close.action = sh "notify-send lid-close";
    #             };

    #           binds =
    #             with config.lib.niri.actions;
    #             let
    #               sh = spawn "sh" "-c";
    #               # screenshot-area-script = pkgs.writeShellScript "screenshot-area" ''
    #               #   grim -o $(niri msg --json focused-output | jq -r .name) - | swayimg --config=info.mode=off --fullscreen - &
    #               #   SWAYIMG=$!
    #               #   niri msg action do-screen-transition -d 1200
    #               #   sleep 1.2
    #               #   grim -g "$(slurp)" - | wl-copy -t image/png
    #               #   niri msg action do-screen-transition
    #               #   kill $SWAYIMG
    #               # '';
    #               # screenshot-area = spawn "${screenshot-area-script}";
    #             in
    #             lib.attrsets.mergeAttrsList [
    #               {
    #                 "Mod+T".action = spawn "kitty";
    #                 "Mod+O".action = show-hotkey-overlay;
    #                 "Mod+D".action = spawn "fuzzel";
    #                 "Mod+W".action = sh (
    #                   builtins.concatStringsSep "; " [
    #                     "systemctl --user restart waybar.service"
    #                   ]
    #                 );

    #                 "Mod+L".action = spawn "blurred-locker";

    #                 "Mod+Shift+S".action = screenshot;
    #                 "Print".action.screenshot-screen = [ ];
    #                 "Mod+Print".action = screenshot-window;

    #                 "Mod+Insert".action = set-dynamic-cast-window;
    #                 "Mod+Shift+Insert".action = set-dynamic-cast-monitor;
    #                 "Mod+Delete".action = clear-dynamic-cast-target;

    #                 "XF86AudioRaiseVolume".action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
    #                 "XF86AudioLowerVolume".action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
    #                 "XF86AudioMute".action = sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

    #                 "XF86MonBrightnessUp".action = sh "brightnessctl set 10%+";
    #                 "XF86MonBrightnessDown".action = sh "brightnessctl set 10%-";

    #                 "Mod+Q".action = close-window;

    #                 "Mod+Space".action = toggle-column-tabbed-display;

    #                 "XF86AudioNext".action = focus-column-right;
    #                 "XF86AudioPrev".action = focus-column-left;

    #                 "Mod+Tab".action = focus-window-down-or-column-right;
    #                 "Mod+Shift+Tab".action = focus-window-up-or-column-left;
    #               }
    #               (binds {
    #                 suffixes."Left" = "column-left";
    #                 suffixes."Down" = "window-down";
    #                 suffixes."Up" = "window-up";
    #                 suffixes."Right" = "column-right";
    #                 prefixes."Mod" = "focus";
    #                 prefixes."Mod+Ctrl" = "move";
    #                 prefixes."Mod+Shift" = "focus-monitor";
    #                 prefixes."Mod+Shift+Ctrl" = "move-window-to-monitor";
    #                 substitutions."monitor-column" = "monitor";
    #                 substitutions."monitor-window" = "monitor";
    #               })
    #               {
    #                 "Mod+V".action = switch-focus-between-floating-and-tiling;
    #                 "Mod+Shift+V".action = toggle-window-floating;
    #               }
    #               (binds {
    #                 suffixes."Home" = "first";
    #                 suffixes."End" = "last";
    #                 prefixes."Mod" = "focus-column";
    #                 prefixes."Mod+Ctrl" = "move-column-to";
    #               })
    #               (binds {
    #                 suffixes."U" = "workspace-down";
    #                 suffixes."I" = "workspace-up";
    #                 prefixes."Mod" = "focus";
    #                 prefixes."Mod+Ctrl" = "move-window-to";
    #                 prefixes."Mod+Shift" = "move";
    #               })
    #               (binds {
    #                 suffixes = builtins.listToAttrs (
    #                   map (n: {
    #                     name = toString n;
    #                     value = [
    #                       "workspace"
    #                       (n + 1)
    #                     ]; # workspace 1 is empty; workspace 2 is the logical first.
    #                   }) (range 1 9)
    #                 );
    #                 prefixes."Mod" = "focus";
    #                 prefixes."Mod+Ctrl" = "move-window-to";
    #               })
    #               {
    #                 "Mod+Comma".action = consume-window-into-column;
    #                 "Mod+Period".action = expel-window-from-column;

    #                 "Mod+R".action = switch-preset-column-width;
    #                 "Mod+F".action = maximize-column;
    #                 "Mod+Shift+F".action = fullscreen-window;
    #                 "Mod+C".action = center-column;

    #                 "Mod+Minus".action = set-column-width "-10%";
    #                 "Mod+Plus".action = set-column-width "+10%";
    #                 "Mod+Shift+Minus".action = set-window-height "-10%";
    #                 "Mod+Shift+Plus".action = set-window-height "+10%";

    #                 "Mod+Shift+Escape".action = toggle-keyboard-shortcuts-inhibit;
    #                 "Mod+Shift+E".action = quit;
    #                 "Mod+Shift+P".action = power-off-monitors;

    #                 "Mod+Shift+Ctrl+T".action = toggle-debug-tint;
    #               }
    #             ];

    #           animations.window-resize.custom-shader = builtins.readFile ./resize.glsl;

    #           window-rules =
    #             let
    #               colors = config.lib.stylix.colors.withHashtag;
    #             in
    #             [
    #               {
    #                 draw-border-with-background = false;
    #                 geometry-corner-radius =
    #                   let
    #                     r = 8.0;
    #                   in
    #                   {
    #                     top-left = r;
    #                     top-right = r;
    #                     bottom-left = r;
    #                     bottom-right = r;
    #                   };
    #                 clip-to-geometry = true;
    #               }
    #               {
    #                 matches = [
    #                   {
    #                     app-id = "^kitty$";
    #                     title = ''^\[oxygen\]'';
    #                   }
    #                 ];
    #                 border.active.color = colors.base0B;
    #               }
    #               {
    #                 matches = [
    #                   {
    #                     app-id = "^firefox$";
    #                     title = "Private Browsing";
    #                   }
    #                 ];
    #                 border.active.color = colors.base0E;
    #               }
    #               {
    #                 matches = [
    #                   {
    #                     app-id = "^signal$";
    #                   }
    #                 ];
    #                 block-out-from = "screencast";
    #               }
    #             ];

    #           gestures.dnd-edge-view-scroll = {
    #             trigger-width = 64;
    #             delay-ms = 250;
    #             max-speed = 12000;
    #           };

    #           layer-rules = [
    #             {
    #               matches = [ { namespace = "^swaync-notification-window$"; } ];

    #               block-out-from = "screencast";
    #             }
    #             {
    #               matches = [ { namespace = "^swww-daemonoverview$"; } ];

    #               place-within-backdrop = true;
    #             }
    #           ];
    #           xwayland-satellite.path = "${lib.getExe pkgs.xwayland-satellite-unstable}";
    #         };
    #       }
    #     )
    #     (
    #       { pkgs, ... }:
    #       {
    #         home.packages = with pkgs; [
    #           libnotify
    #         ];
    #         programs.foot = {
    #           enable = true;
    #           settings.csd.preferred = "none";
    #         };

    #         programs.alacritty = {
    #           enable = true;
    #           settings = {
    #             window.decorations = "None";
    #           };
    #         };

    #         programs.kitty = {
    #           enable = true;
    #           settings = {
    #             window_border_width = "0px";
    #             tab_bar_edge = "top";
    #             tab_bar_margin_width = "0.0";
    #             tab_bar_style = "fade";
    #             placement_strategy = "top-left";
    #             hide_window_decorations = true;
    #           };
    #         };

    #         programs.fuzzel = {
    #           enable = true;
    #           settings.main.launch-prefix = "niri msg action spawn --";
    #           settings.main.terminal = "foot";
    #         };

    #         # services.mako = {
    #         #   enable = true;
    #         #   borderRadius = 8;
    #         #   format = "%a\n%s\n%b";
    #         # };

    #         services.swaync = {
    #           enable = true;
    #         };
    #       }
    #     )
    #   ];
    };
}