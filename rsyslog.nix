{ ... }: 
{
  services.rsyslogd = {
    enable = true;
    extraConfig = ''
      # source: https://alexandre.deverteuil.net/post/syslog-relay-for-loki/
      # https://www.rsyslog.com/doc/v8-stable/concepts/multi_ruleset.html#split-local-and-remote-logging
      ruleset(name="remote"){
        # https://www.rsyslog.com/doc/v8-stable/configuration/modules/omfwd.html
        # https://grafana.com/docs/loki/latest/clients/promtail/scraping/#rsyslog-output-configuration
        action(type="omfwd" Target="127.0.0.1" Port="1514" Protocol="tcp" Template="RSYSLOG_SyslogProtocol23Format" TCP_Framing="octet-counted")
      }


      # https://www.rsyslog.com/doc/v8-stable/configuration/modules/imudp.html
      module(load="imudp")
      input(type="imudp" port="514" ruleset="remote")

      # https://www.rsyslog.com/doc/v8-stable/configuration/modules/imtcp.html
      module(load="imtcp")
      input(type="imtcp" port="514" ruleset="remote")
    '';
  };
}
