{
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    defaultOptions = [
      "--layout=reverse"
      "--info=inline"
    ];
    fileWidgetOptions = [
      "--border=rounded"
      "--margin=1"
      "--padding=1"
      "--preview 'if [ -d {} ]; then eza --tree --level 2 --color=always {}; else bat --color=always --line-range :500 {}; fi'"
    ];
    changeDirWidgetOptions = [
      "--border=rounded"
      "--margin=1"
      "--padding=1"
      "--preview 'eza --tree --level 2 --color=always {} | head -200'"
    ];
  };
}
