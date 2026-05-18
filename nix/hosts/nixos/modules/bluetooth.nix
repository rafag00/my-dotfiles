{pkgs, ...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };

  # For some reason bluetooth is disabling at suspend so...
  systemd.services.bluetooth-power-on-after-resume = {
    description = "Power on Bluetooth after resume";
    wantedBy = [
      "suspend.target"
      "hibernate.target"
      "hybrid-sleep.target"
      "suspend-then-hibernate.target"
    ];
    after = [
      "suspend.target"
      "hibernate.target"
      "hybrid-sleep.target"
      "suspend-then-hibernate.target"
      "bluetooth.service"
    ];

    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      sleep 5
      ${pkgs.bluez}/bin/bluetoothctl power on
    '';
  };

  #services.blueman.enable = true;
}
