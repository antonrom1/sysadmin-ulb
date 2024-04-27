{...}: {
  programs.zsh = {
    autocd = true;
    defaultKeymap = "emacs";
    # TODO: add dirHashes: https://blog.myelin.ch/2018/12/14/named-directory-hash-table.html
    #  https://mynixos.com/home-manager/option/programs.zsh.dirHashes
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    history.share = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git" # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
        "docker"
      ];
      theme = "fishy";
    };
    initExtra = ''
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg(=5'
    '';
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
