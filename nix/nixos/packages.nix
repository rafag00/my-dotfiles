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
    ];

    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
    ];

}
