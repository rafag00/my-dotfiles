{ pkgs, ... }: {

    nixpkgs.config = {
        allowUnfree = true;

    };

    environment.systemPackages = with pkgs; [

        # Desktop apps
        distrobox
        docker
        firefox
        ghostty
        github-desktop
        gnome-text-editor
        keepassxc
        vscode

        # Work apps
        libreoffice
        slack
        teams-for-linux
        thunderbird # home-manager config
        zotero

        # CLI utils
        bash
        bash-completion
        bluez
        bluez-tools
        eza
        fastfetch
        fzf
        git
        nano
        nix-bash-completions
        oh-my-posh
        rclone

        # Sound
        pipewire
        pulseaudio
        pamixer

        # Other
        home-manager
        sbctl
        hunspell
        hunspellDicts.en_US
        hunspellDicts.pt_PT

        # For sddm-astronaut
        kdePackages.qtsvg
        kdePackages.qtmultimedia
        kdePackages.qtvirtualkeyboard
        
    ];

    fonts.packages = with pkgs; [
        ibm-plex
        inter
        nerd-fonts.fira-code
        nerd-fonts.jetbrains-mono
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
    ];

}
