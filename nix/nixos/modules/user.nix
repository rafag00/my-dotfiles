{ pkgs, ... }: {

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users = {

        defaultUserShell = pkgs.bash;

        users.rafag00 = {
            isNormalUser = true;
            extraGroups = [ "networkmanager" "wheel" ];
            packages = with pkgs; [];
        };

    };

    # Enable automatic login for the user.
    services.getty.autologinUser = "rafag00";
}
