{ pkgs, pkgs-unstable, inputs, system, ... }: {

    nixpkgs.config = {
        allowUnfree = true;
    };

    environment.systemPackages = 
    (
        with pkgs; [

        # Desktop apps - move to home manager programs.enable
        docker
        github-desktop
        gnome-text-editor

        # Work apps
        libreoffice
        slack
        teams-for-linux
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
        libsecret

        # For sddm-astronaut
        kdePackages.qtsvg
        kdePackages.qtmultimedia
        kdePackages.qtvirtualkeyboard
        kdePackages.kwallet
        kdePackages.kwallet-pam

        cachix

    ])
    ++
    ( with pkgs-unstable; [
        inputs.noctalia.packages.${system}.default
        # ... maybe other stuff
    ]);

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
