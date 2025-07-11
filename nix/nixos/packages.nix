{ pkgs, ... }: {

    nixpkgs.config = {
        allowUnfree = true;

    };

    environment.systemPackages = with pkgs; [

        # Desktop apps
        firefox
        ghostty # home-manager config
        vscode
        keepassxc
        github-desktop
        docker
        distrobox
        gnome-text-editor

        # Work apps
        teams-for-linux
        slack
        zotero
        thunderbird # home-manager config
        libreoffice

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
        hunspell
        hunspellDicts.en_US
        hunspellDicts.pt_PT

        # For sddm-astronaut
        kdePackages.qtsvg
        kdePackages.qtmultimedia
        kdePackages.qtvirtualkeyboard
        
    ];

    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        fira
        roboto
        nerd-fonts.jetbrains-mono
    ];

}
