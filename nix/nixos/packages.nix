{ pkgs, ... }: {

    nixpkgs.config = {
        allowUnfree = true;

    };

    environment.systemPackages = with pkgs; [

        # Desktop apps
        firefox
        ghostty
        vscode
        keepassxc
        github-desktop
        docker
        distrobox
        #need to use distrobox for notion

        # Work apps
        teams-for-linux
        slack
        zotero
        thunderbird # home-manager config
        libreoffice
        #Search for docker 

        # CLI utils
        bash
        bash-completion
        nix-bash-completions
        oh-my-posh
        nano
        fastfetch
        eza
        fzf
        bluez
        bluez-tools
        rclone
        git


        # Sound
        pipewire
        pulseaudio
        pamixer

        # Other
        home-manager
        sbctl

        # For sddm-astronaut
        kdePackages.qtsvg
        kdePackages.qtmultimedia
        kdePackages.qtvirtualkeyboard
        
    ];

    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
    ];

}
