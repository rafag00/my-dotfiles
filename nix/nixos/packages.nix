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


        # Sound
        pipewire
        pulseaudio
        pamixer

        # Other
        home-manager
    ];

    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
    ];

}
