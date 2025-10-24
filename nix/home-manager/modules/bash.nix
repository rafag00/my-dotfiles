{
    programs.bash = {
        enable = true;
        enableCompletion = true;

        shellAliases =
            let
                flakeDir = "~/nix/";
            in {
                rebuild = "sudo nixos-rebuild switch --flake ${flakeDir}";
                update = "cd ${flakeDir} && nix flake update && cd ~";
                upgrade = "sudo nixos-rebuild switch --upgrade --flake ${flakeDir}";

                # hms = "home-manager switch --flake ${flakeDir}"; # Now deactivated as home manager is integrated

                ff = "fastfetch -c ~/nix/home-manager/extra/fastfetchConfig.json";
                shutdown="systemctl poweroff";

                #keep-presence = "cd ~/nix/home-manager/extra/keep-presence/ && nix-shell --run \"keep-presence -s time\" && cd ~";

                gs = "git status";
                ga = "git add";
                gc = "git commit -m";
                gp = "git push";
                gpl = "git pull";
                gst = "git stash";
                gsp = "git stash; git pull";
                gcheck = "git checkout";
                gcredential = "git config credential.helper store";
        };

        initExtra = ''
            eval "$(oh-my-posh init bash --config ~/nix/home-manager/extra/tokyo.omp.json)"

            fastfetch -c ~/nix/home-manager/extra/fastfetchConfig.json

            keep-presence() {
                cd ~/nix/home-manager/extra/keep-presence/
                nix-shell --run "keep-presence -s \"$@\""
                cd ~
            }
        '';
    };
}
