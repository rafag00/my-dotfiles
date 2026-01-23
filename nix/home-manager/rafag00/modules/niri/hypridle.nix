{...}: {
  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          ignore_dbus_inhibit = false;
          after_sleep_cmd = "niri msg output eDP-1 on && niri msg output HDMI-A-1 on"; # to avoid having to press a key twice to turn on the display.
        };
        listener = [
          {
            timeout = 300; # 5min.
            on-timeout = "brightnessctl -s set 0"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
            on-resume = "brightnessctl -r"; # monitor backlight restore.
          }
          {
            timeout = 600; # 10 min
            on-timeout = "noctalia-shell ipc call lockScreen lock && niri msg output eDP-1 off && niri msg output HDMI-A-1 off";
            on-resume = "niri msg output eDP-1 on && niri msg output HDMI-A-1 on";
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
