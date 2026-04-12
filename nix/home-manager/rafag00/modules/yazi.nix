{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    shellWrapperName = "y";
    plugins = {
      git = "${pkgs.yaziPlugins.git}";
      sudo = "${pkgs.yaziPlugins.sudo}";
      drag = "${pkgs.yaziPlugins.drag}";
      lazygit = "${pkgs.yaziPlugins.lazygit}";
    };
  };
}
