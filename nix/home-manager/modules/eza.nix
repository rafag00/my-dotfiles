{
    programs.eza = {
        enable = true;
        enableBashIntegration = true;
        colors = "always";
        icons = "always";
        git = true;
        extraOptions = [
            "--group-directories-first"
            "--header"
        ];
    };
}
