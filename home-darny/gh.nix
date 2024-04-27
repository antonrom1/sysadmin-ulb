{ pkgs, ... }:
{
  # authentication does not work yet as .config/gh/config.yml is not writable
  # https://github.com/nix-community/home-manager/issues/1654
  # in the meantime, i installed gh as in home.packages
  #  programs.gh = {
  #    enable = true;
  #  };

  home.packages = with pkgs; [
     gh
  ];
}