{
  pkgs,
  host,
  ...
}: {
  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  #networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;
  services.resolved.enable = false;

  networking = {
    hostName = "${host}";

    resolvconf.enable = true;

    networkmanager = {
      enable = true;
      #dns = "none";
      dns = "default";
      plugins = with pkgs; [
        networkmanager-openvpn
      ];
    };

    useDHCP = false;
    dhcpcd.enable = false;

    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "208.67.222.222"
      "208.67.220.220"
    ];

    extraHosts = ''
      # 213.30.51.243 proxy.onemnef.com
      # 213.30.51.243 capif.onesource.dev register.onesource.dev
      # 213.30.51.243 invoker-app.n-app.com
      # 213.30.51.243 proxy-open5gs.com
      10.2.0.89 proxy.onemnef.com
      10.2.0.89 capif.onesource.dev register.onesource.dev
      10.2.0.89 invoker-app.n-app.com
      10.2.0.89 proxy-open5gs.com
    '';

    # Open ports in the firewall.
    #networking.firewall.allowedTCPPorts = [ 22 ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Enabled for KDE Connect
    firewall = rec {
      #trustedInterfaces = ["docker0"];
      #checkReversePath = false;

      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };
}
