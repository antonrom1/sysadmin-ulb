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
    boulanger = {
      isNormalUser = true;
      uid = 1003;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "systemd-journal" ];
      openssh.authorizedKeys.keys = [
        "${builtins.readFile ./home-boulanger/ssh.pub}"
      ];
    };
    root.packages = with pkgs; [ git vim ];
    root.openssh.authorizedKeys.keys = [
      # these users are allowed to rebuild the machine from remote as doing that requires root ssh access 
      # nixos-rebuild --target-host root@192.168.11.3 --build-host "root@192.168.11.3" --fast --flake ".#grafix" switch
      "${builtins.readFile ./home-anton/ssh.pub}"
      "${builtins.readFile ./home-darny/ssh.pub}"
    ];
  };
}
