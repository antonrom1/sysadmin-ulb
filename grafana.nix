{ pkgs, lib, config, ... }:
{
  # grafana configuration
  services.grafana = {
    enable = true;
    settings.server = {
      http_addr = "192.168.11.3";
      http_port = 3000;
      domain = "192.168.11.3";
    };
  };
}
