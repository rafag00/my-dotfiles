{ pkgs, pkgs-stable, myPkgs, inputs, system, ... }: {

    nixpkgs.config = {
        allowUnfree = true;
    };

    environment.systemPackages = 
    (
        with pkgs; [

        inputs.noctalia.packages.${system}.default

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
        ripgrep # Improved Grep
        unrar # Tool For Handling .rar Files
        unzip # Tool For Handling .zip Files
        zip
        usbutils # Good Tools For USB Devices

        # Sound
        pipewire

        # Other
        appimage-run # run appimages
        home-manager
        gpu-screen-recorder

        # For sddm-astronaut
        kdePackages.qtsvg
        kdePackages.qtmultimedia
        kdePackages.qtvirtualkeyboard
        kdePackages.kwallet
        kdePackages.kwallet-pam
        
        nh

    ])
     ++
     ( with pkgs-stable; [

        sbctl
        hunspell
        hunspellDicts.en_US
        hunspellDicts.pt_PT
        libsecret

        cachix
     ])
     ++
     [
        (pkgs.callPackage ./myPkgs/Notion { })
     ];


    fonts.packages = with pkgs; [
        ibm-plex
        inter-nerdfont
        nerd-fonts.fira-code
        nerd-fonts.jetbrains-mono
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
    ];

}
