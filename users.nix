{ config, pkgs, ... }: 
{
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };

  users.defaultUserShell = pkgs.zsh;

  users.users = { 
    anton = {
      isNormalUser = true;
      uid = 1000;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "systemd-journal" ];
      openssh.authorizedKeys.keys = [
        "${builtins.readFile ./home-anton/ssh.pub}"
      ];
    };
    darny = {
      isNormalUser = true;
      uid = 1001;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "systemd-journal" ];
      openssh.authorizedKeys.keys = [
        "${builtins.readFile ./home-darny/ssh.pub}"
      ];
    };
    sorio = {
      isNormalUser = true;
      uid = 1002;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "systemd-journal" ];
      openssh.authorizedKeys.keys = [
        "${builtins.readFile ./home-sorio/ssh.pub}"
      ];
    };
    root.packages = with pkgs; [ git vim ];
    root.openssh.authorizedKeys.keys = [
      "${builtins.readFile ./home-anton/ssh.pub}"
    ];
  };
}
