# TODO: check the validity of this template
# from https://xeiaso.net/blog/prometheus-grafana-loki-nixos-2020-11-20

# see more this: https://gist.github.com/rickhull/895b0cb38fdd537c1078a858cf15d63e

{ config, pkgs,... }: {
  services.loki = {
    enable = true;
    configFile = ./loki.yaml;
    #configuration = {
    #  auth_enabled = false;
    #  server = {
    #    http_listen_port = 3100;
    #    http_server_read_timeout = "60s";
    #    http_server_write_timeout = "60s";
    #    grpc_server_max_recv_msg_size = 33554432;
    #    grpc_server_max_send_msg_size = 33554432;
    #    log_level = "info";
    #  };

    #  ingester = {
    #    lifecycler = {
    #      final_sleep = "0s";
    #    };
    #    chunk_idle_period = "1h";
    #    max_chunk_age = "1h";
    #    chunk_target_size = 1048576;
    #    chunk_retain_period = "30s";
    #    # max_transfer_retries = 0;
    #  };

    #  # schema_config = {
    #  #   configs = [{
    #  #     from = "2020-11-01";
    #  #     store = "boltdb-shipper";
    #  #     object_store = "filesystem";
    #  #     schema = "v11";
    #  #     index = {
    #  #       prefix = "index_";
    #  #       period = "24h";
    #  #     };
    #  #   }];
    #  # };

    #  storage_config = {
    #    # boltdb_shipper = {
    #    #   active_index_directory = "/var/lib/loki/boltdb-shipper-active";
    #    #   cache_location = "/var/lib/loki/boltdb-shipper-cache";
    #    #   cache_ttl = "72h";
    #    #   shared_store = "filesystem";
    #    # };
    #    # boltdb = {
    #    #   directory = "/var/lib/loki/index";
    #    # };

    #    filesystem = {
    #      directory = "/var/lib/loki/chunks";
    #    };
    #  };

    #  compactor = {
    #    working_directory = "/var/lib/loki/compactor";
    #    # shared_store = "filesystem";
    #    compaction_interval = "10m";
    #    retention_enabled = true;
    #    retention_delete_delay = "2h";
    #    retention_delete_worker_count = 150;
    #  };

    #  limits_config = {
    #    retention_period = "31d";
    #    # enforce_metric_name = false;
    #    reject_old_samples = true;
    #    reject_old_samples_max_age = "168h";
    #    ingestion_rate_mb = 8;
    #    ingestion_burst_size_mb = 16;
    #    per_stream_rate_limit = "5MB";
    #    per_stream_rate_limit_burst = "15MB";
    #    max_query_length = "2165h";
    #    max_query_lookback = "90d";
    #    max_entries_limit_per_query = 10000;
    #  };

    #  querier.max_concurrent = 80;

    #  frontend = {
    #    max_outstanding_per_tenant = 2048;
    #    compress_responses = true;
    #    log_queries_longer_than = "20s";
    #  };

    #  frontend_worker = {
    #    grpc_client_config = {
    #      max_send_msg_size = 33554432;
    #      max_recv_msg_size = 33554432;
    #    };
    #  };

    #  ingester_client = {
    #    grpc_client_config = {
    #      max_send_msg_size = 33554432;
    #      max_recv_msg_size = 33554432;
    #    };
    #  };

    #  query_scheduler = {
    #    grpc_client_config = {
    #      max_send_msg_size = 33554432;
    #      max_recv_msg_size = 33554432;
    #    };
    #  };

    #  # query_range.split_queries_by_interval = 0;

    #  ruler = {
    #    storage = {
    #      type = "local";
    #      local.directory = "/var/lib/loki/rules";
    #    };
    #    rule_path = "/var/lib/loki/rules-temp";
    #    enable_alertmanager_v2 = true;
    #    alertmanager_client = {
    #      basic_auth_username = "loki_alertmanager";
    #      #TODO the needs to move to sops secret config.sops.secrets.loki-alertmanager-password.path
    #      basic_auth_password = "loki_alertmanager";
    #    };
    #  };

    #  common = {
    #    path_prefix = "/var/lib/loki";
    #    replication_factor = 1;
    #    ring = {
    #      instance_addr = "127.0.0.1";
    #      kvstore.store = "inmemory";
    #    };
    #  };

    #  #chunk_store_config = {
    #  #  max_look_back_period = "0s";
    #  #};

    #  #table_manager = {
    #  #  retention_deletes_enabled = false;
    #  #  retention_period = "0s";
    #  #};

    #};
  };
}
