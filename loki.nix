# TODO: check the validity of this template
# from https://xeiaso.net/blog/prometheus-grafana-loki-nixos-2020-11-20

# see more this: https://gist.github.com/rickhull/895b0cb38fdd537c1078a858cf15d63e

{ config, pkgs,... }: {
  services.loki = {
    enable = true;
    configFile = ./loki.yaml;
  };
}
