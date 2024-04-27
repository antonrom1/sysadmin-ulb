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
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDCO1/LAQj6DylIRG2fHVnO9njZuq6JhEobhoWRUAAIwht2N91HU1XolimLXiFyei7rWhmxqXC4p/a5Tc91UtyG+/Ij9JJhWd4A24+N3l38nHcTvxjX2EqslskPRvOJRtlIe48PbhmgZ25Qk6SRMxYudBCMNbgVbBqo9+DPDveBXVWFCrc81odLQmLPMIqvNE503kX4G2BrXhlmp2Q2awJNNoE4DTE3zOYfxzB3kdM2RzNPC3yd13pnNp1QTQ+oBGN0je/Zt9ZU/lhUR/LfDlnu0RMlYZI7ZFYUGc1Xr8f/jsP0wxb5btm1cxjMbtkYR1W2szFFTDx+iFaunXhYwLp7cS9vCYNUWaPM0g9SIaqmub1IeEO7o/xopOKmw4Nmm3eeanGPrPXAV4WKiZvIDJquccERroTi5/uW3BAKRR6e34kBPb9Ui8MaD+tqmQhE0ZJhNzurC6P3sZUpx26wcY6yVQYkZRJlMCfMcPbnES4z072JmPztIWi+HddiDmPBwBE= anton@Antons-Air"
      ];
    };
    darny = {
      isNormalUser = true;
      uid = 1001;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "systemd-journal" ];
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCxUMmNAI9vR3N85RE+Ce/vL+76X2C7EMUybuejmYp/tzP7uagcxABfpbkth46UCq8u7Qn6AwxenRl+PLn5UHAK6wVacFDI9kWF3fKFN9o1VYCz96qE8C5WqhbvWfMyMXKGgNIbQDloGshT/gB45AKYrJiJLvfWQyaBTOBjVosAV1zmJqWrNLniS/y3AjY8Q6xg5iD3d6ZQ4X9BWdxe+j4m8AnKso84Rrv7DwU7vtNS5SuLbJmxeMsb/Yv9WN0fedymsk1gQp6zbhsvOrMc3rd/Y0k6tzy5hbkaZlwoB3AjHeiXDAqxI4AL4vqOs/jLCEFY90LuXDr9ZC2l5QVUwIqfm9mxkeenSCUQ/03lRPwczWK9wSt5Rb3+lbGU8K3rCXcpwbmFIOxS9ttQE31d4PwrUPpRcJ1cYedFR4F2o+AvYxns2E3MlsZ4FqIalldUW2SLqpjgaxNkb+YGdoNc++sZOipZCcaoa551GLP+84P8kXMMigvgVfKMCOq+fxNLk9s= darny@DARNYBOX"
      ];
    };
    root.packages = with pkgs; [ git vim ];
    root.openssh.authorizedKeys.keys = [
      # Anton
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDCO1/LAQj6DylIRG2fHVnO9njZuq6JhEobhoWRUAAIwht2N91HU1XolimLXiFyei7rWhmxqXC4p/a5Tc91UtyG+/Ij9JJhWd4A24+N3l38nHcTvxjX2EqslskPRvOJRtlIe48PbhmgZ25Qk6SRMxYudBCMNbgVbBqo9+DPDveBXVWFCrc81odLQmLPMIqvNE503kX4G2BrXhlmp2Q2awJNNoE4DTE3zOYfxzB3kdM2RzNPC3yd13pnNp1QTQ+oBGN0je/Zt9ZU/lhUR/LfDlnu0RMlYZI7ZFYUGc1Xr8f/jsP0wxb5btm1cxjMbtkYR1W2szFFTDx+iFaunXhYwLp7cS9vCYNUWaPM0g9SIaqmub1IeEO7o/xopOKmw4Nmm3eeanGPrPXAV4WKiZvIDJquccERroTi5/uW3BAKRR6e34kBPb9Ui8MaD+tqmQhE0ZJhNzurC6P3sZUpx26wcY6yVQYkZRJlMCfMcPbnES4z072JmPztIWi+HddiDmPBwBE= anton@Antons-Air"
    ];
  };
}
