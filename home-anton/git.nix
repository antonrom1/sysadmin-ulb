{ pkgs, lib, config, ... }:
let
  ssh = "${pkgs.openssh}/bin/ssh";
in
{
  programs.git = {
    enable = true;
    package = pkgs.git;
    userName = "Anton Romanova";
    userEmail = "contact@antonromanova.com";
    extraConfig = {
      init.defaultBranch = "main";
      #commit.gpgSign = true;
      gpg.program = "${config.programs.gpg.package}/bin/gpg2";

      merge.conflictStyle = "zdiff3";
      commit.verbose = true;
      diff.algorithm = "histogram";
      log.date = "iso";
      column.ui = "auto";
      branch.sort = "committerdate";
      # Automatically track remote branch
      push.autoSetupRemote = true;
      # Reuse merge conflict fixes when rebasing
      rerere.enabled = true;

      core.editor = "vim";
    };
    lfs.enable = true;

    # syntax highlighted diffs
    difftastic.enable = true;
    ignores = [ ".direnv" ".idea" ".DS_Store" ];
  };
}
