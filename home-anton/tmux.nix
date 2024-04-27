{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    # maybe change this to a different key so i can use embedded tmux without double clicking the prefix
    shortcut = "b";
    shell = "${pkgs.zsh}/bin/zsh";
    tmuxinator.enable = true;
  };
}