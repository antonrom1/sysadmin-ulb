{ pkgs, config, home, ... }:
{

  # If I every change anything with this agent, changes might not apply until I restart gpgconf agent
  # gpgconf --kill gpg-agent

  home.packages = with pkgs; [
    gnupg
  ];

  services.gpg-agent = {
    enable = pkgs.stdenv.isLinux;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableScDaemon = true;
    defaultCacheTtl = 14400;
    maxCacheTtl = 86400;
    pinentryPackage = pkgs.pinentry-curses;
    enableSshSupport = true;
    defaultCacheTtlSsh = 14400;
    maxCacheTtlSsh = 86400;
    sshKeys = null;
  };


  programs.gpg = {
    enable = true;
    publicKeys = [{
      source = ./pgp.asc;
      trust = 5;
    }];
  };
}
