{ ... }: {
  services.influxdb = {
    enable = true;
    dataDir = "/var/lib/influxdb";
    package = pkgs.influxdb;
    extraConfig = {
      collectd = [{
        enabled = true;
        typesdb = "${pkgs.collectd-data}/share/collectd/types.db";
        database = "collectdb";
        bind-address = ":25826";
      }];
    };
  };
  systemd.services.influxdb = {
    before = [ "grafana.service" ];
    # copied from https://github.com/freifunkhamburg/stats-nixos-config/blob/c2dfab41631908872bd75c93c2d85f414c0ca26a/influxdb.nix
    preStart = ''
        [ -d /var/lib/influxdb/meta ] || touch /var/lib/influxdb/need-init
        '';
    postStart = ''
    set -euo pipefail
    if [ ! -s /var/lib/influxdb/admin.pw ]; then
      ( tr -dc _A-Z-a-z-0-9 </dev/urandom || : ) | head -c32 > /var/lib/influxdb/admin.pw
      chmod 400 /var/lib/influxdb/admin.pw
    fi
    if [ ! -s /var/lib/influxdb/openwrtclient.pw ]; then
      ( tr -dc _A-Z-a-z-0-9 </dev/urandom || : ) | head -c32 > /var/lib/influxdb/openwrtclient.pw
      chmod 400 /var/lib/influxdb/openwrtclient.pw
    fi
    if [ ! -s /var/lib/influxdb/grafana.pw ]; then
      ( tr -dc _A-Z-a-z-0-9 </dev/urandom || : ) | head -c32 > /var/lib/influxdb/grafana.pw
      chmod 400 /var/lib/influxdb/grafana.pw
    fi
    until ${pkgs.curl}/bin/curl --connect-timeout 1 http://127.0.0.1:8086/ping; do
      sleep 1
    done
    if [ -e /var/lib/influxdb/need-init ]; then
      rm -f /var/lib/influxdb/need-init
      read -N 32 -r adminpw < /var/lib/influxdb/admin.pw
      read -N 32 -r openwrtclient < /var/lib/influxdb/openwrtclient.pw
      read -N 32 -r grafanapw < /var/lib/influxdb/grafana.pw
      ${config.services.influxdb.package}/bin/influx -execute "create user admin with password '$adminpw' WITH ALL PRIVILEGES"
      ${config.services.influxdb.package}/bin/influx -username admin -password "$adminpw" -execute 'CREATE DATABASE collectdb'
      ${config.services.influxdb.package}/bin/influx -username admin -password "$adminpw" -execute 'CREATE RETENTION POLICY "default" ON "collectdb" DURATION 90d REPLICATION 1 SHARD DURATION 1d DEFAULT'
      ${config.services.influxdb.package}/bin/influx -username admin -password "$adminpw" -database collectdb -execute "grant all on collectdb to admin"
      ${config.services.influxdb.package}/bin/influx -username admin -password "$adminpw" -database collectdb -execute "create user grafana with password '$grafanapw'"
      ${config.services.influxdb.package}/bin/influx -username admin -password "$adminpw" -database collectdb -execute "create user openwrtclient with password '$openwrtclientpw'"
      ${config.services.influxdb.package}/bin/influx -username admin -password "$adminpw" -database collectdb -execute "grant read on collectdb to grafana"
      ${config.services.influxdb.package}/bin/influx -username admin -password "$adminpw" -database collectdb -execute "grant write on collectdb to openwrtclient"
    fi
    '';
  };
}
