# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./users.nix
      ./grafana.nix
      ./loki.nix
      ./promtail.nix
      ./rsyslog.nix
      ./influxdb.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "grafix"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  networking = {
    useDHCP = false;
    interfaces.ens18.useDHCP = false;
    interfaces.ens18.ipv4 = {
      addresses = [{
        address = "192.168.11.3";
        prefixLength = 24;
      }];
    };
    defaultGateway = "192.168.11.1";
    nameservers = ["8.8.8.8" "8.8.4.4"];
  };

  # Set your time zone.
  time.timeZone = "Europe/Brussels";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "gb";
    variant = "mac";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # nix extra options
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    influxdb  # influx in PATH so we can debug it
  ];
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "bira";
      plugins = ["git" "docker-compose"];
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 
    3000 # grafana
    8086 # influxdb
    3030 # loki
    514  # rsyslog, probably communicates through UDP, so we need to remove this line
  ];
  networking.firewall.allowedUDPPorts = [
    25826 # collectd
    514   # rsyslog
  ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
