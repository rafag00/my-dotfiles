{
  pkgs,
  pkgs-stable,
  myPkgs,
  inputs,
  system,
  ...
}: {
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
        bat
        bluez
        bluez-tools
        btop
        fastfetch
        git
        gnumake
        nano
        nix-bash-completions
        wget
        rclone
        ripgrep # Improved Grep
        unrar # Tool For Handling .rar Files
        unzip # Tool For Handling .zip Files
        zip
        usbutils # Good Tools For USB Devices

        # Sound
        pipewire
        pulseaudio # To have pactl command for the vicinae extension

        # Other
        appimage-run # run appimages
        home-manager
        gpu-screen-recorder

        # Nix
        nh
      ]
    )
    ++ (with pkgs-stable; [
      sbctl
      hunspell
      hunspellDicts.en_US
      hunspellDicts.pt_PT
      libsecret

      cachix
    ])
    ++ [
      (pkgs.callPackage ./myPkgs/Notion {})
      (pkgs.callPackage ./myPkgs/qt6ct-kde {})
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
