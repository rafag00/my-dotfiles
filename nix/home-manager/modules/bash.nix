{
    programs.bash = {
        enable = true;
        enableCompletion = true;

        shellAliases =
            let
                flakeDir = "~/nix/";
            in {
                rebuild = "sudo nixos-rebuild switch --flake ${flakeDir}";
                update = "nix flake update ${flakeDir}";
                upgrade = "sudo nixos-rebuild switch --upgrade --flake ${flakeDir}";

                hms = "home-manager switch --flake ${flakeDir}";

                ff = "fastfetch -c ~/.config/fastfetch/config.json";
                shutdown="systemctl poweroff";

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
        '';
    };
}
