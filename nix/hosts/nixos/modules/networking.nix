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
  services.resolved.enable = true;

  networking = {
    hostName = "${host}";

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      plugins = with pkgs; [
        networkmanager-openvpn
      ];
      connectionConfig."ipv4.ignore-auto-dns" = true;
      connectionConfig."ipv6.ignore-auto-dns" = true;
    };

    useDHCP = false;

    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "208.67.222.222"
      "208.67.220.220"
    ];

    # Open ports in the firewall.
    #networking.firewall.allowedTCPPorts = [ 22 ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Enabled for KDE Connect
    firewall = rec {
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
