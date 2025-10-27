{ ... }:
{   # At the moment only works for one screen
    services = {
        hypridle = {
            enable = true;
            settings = {
                general = {
                    ignore_dbus_inhibit = false;
                    after_sleep_cmd = "niri msg output eDP-1 on";  # to avoid having to press a key twice to turn on the display.
                };
                listener = [
                    {
                        timeout = 150; # 2.5min.
                        on-timeout = "brightnessctl -s set 10"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
                        on-resume = "brightnessctl -r"; # monitor backlight restore.
                    }
                    {
                        timeout = 600; # 10 min
                        on-timeout = "niri msg output eDP-1 off && noctalia-shell ipc call lockScreen lock";
                        on-resume = "niri msg output eDP-1 on";
                    }
                    {
                        timeout = 1800;
                        on-timeout = "noctalia-shell ipc call sessionMenu lockAndSuspend";
                    }
                ];
            };
        };
    };
}
