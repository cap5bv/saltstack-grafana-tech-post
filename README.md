# Auto-provisioning Grafana API with SaltStack 


This repository contains salt state and script examples as part of the following article:

https://cap5.nl/grafana-tech-auto-provisioning-of-website-dashboards-at-scale-with-saltstack-and-the-grafana-api/

Community reference:

https://community.grafana.com/t/grafana-dashboards-as-code-for-newcomers/5334

# Setup information
This setup requires a running Saltstack and an installed TIG/Grafana application stack (somewhere).

Adjust the paths in the salt state to your own setup.
```
- source: salt://{{ stack_name }}/grafana/files/dashboard_single_website.json
```

Add the pillar info for the server where you deploy this.
```
servers:
  your_server:
    roles:
      - tigserver

    tig_stack:
      grafana:
        api_auth: VERYSECRET
        api_server: your.grafana-fqdn.com
```


Command line example (for testing) and how to feed it pillar data.

```
salt your_server state.apply stack_tig.grafana.wpc_grafana_dashboard_update pillar='{"wpc": { "sites": {"cap5.nl": {"node": "srvAA", content_check_strings": {"/": "/wp-content/themes/"}}}, "accept.cap5.nl": {"node": "srvBB", "content_check_strings": {"/": "/wp-content/themes/"}}}}'
```

Note: I usually have an additional root defined at `/srv/apps` for my stack
states. Where you can add sub stack components like `Grafana`.

```
stack_tig/
├── README_stack.md
├── grafana
│   ├── README.md
│   ├── files
│   │   ├── dashboard_single_website.json
│   │   ├── upload_grafana_dashboard.sh
│   │   └── wpc_in.json
│   ├── install_dashboard_generator.sls
│   ├── install_grafana.sls
│   └── wpc_grafana_dashboard_update.sls
├── init.sls
```

Happy trails!
