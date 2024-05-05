{ config, ...}:
{
  services.promtail = {
    enable = true;
    configuration = {
      server = {
        http_listen_port = 9080;
        grpc_listen_port = 0;
      };

      clients = [
        {
          url = "http://127.0.0.1:3100/loki/api/v1/push";
          # TODO: basic_auth
        }
      ];

      scrape_configs = [
        {
          job_name = "journal";
          journal = {
            json = false;
            max_age = "12h";
            path = "/var/log/journal";
            labels = {
              job = "systemd-journal";
            };
          };
          relabel_configs = [
            {
              source_labels = ["'__journal__systemd_unit'"];
              target_label = "'unit'";
            }
            {
              source_labels = ["'__journal__hostname'"];
              target_label = "host";
            }
            {
              source_labels = ["'__journal_container_name'"];
              target_label = "container_name";
            }
          ];
        }
        {
          job_name = "syslog";
          syslog = {
            listen_address = "127.0.0.1:1514";
            labels = {
              job = "syslog";
            };
          };
          relabel_configs = [
            {
              source_labels = ["'__syslog_message_hostname'"];
              target_label = "host";
            }
            {
              source_labels = ["'__syslog_message_hostname'"];
              target_label = "hostname";
            }
            {
              source_labels = ["'__syslog_message_severity'"];
              target_label = "level";
            }
            {
              source_labels = ["'__syslog_message_app_name'"];
              target_label = "application";
            }
            {
              source_labels = ["'__syslog_message_facility'"];
              target_label = "facility";
            }
            {
              source_labels = ["'__syslog_connection_hostname'"];
              target_label = "connection_hostname";
            }
          ];
        }
      ];
    };
  };
}
