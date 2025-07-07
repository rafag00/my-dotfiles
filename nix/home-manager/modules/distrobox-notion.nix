{
    programs.distrobox = {
        enable = true;
        containers = {
            notion-arch = {
                image = "archlinux:latest";
                start_now = true;

                # Can't use init_hooks because it requires sudo
                    #   distrobox enter notion-arch
                    # sudo pacman -S --needed --noconfirm git base-devel fastfetch breeze && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm && yay -Syu --noconfirm notion-app-electron && distrobox-export --app notion-app
            };
        };
    };
}