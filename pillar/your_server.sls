servers:
  your_server:
    roles:
      - tigserver

    tig_stack:
      grafana:
        api_auth: VERYSECRET
        api_server: your.grafana-fqdn.com
