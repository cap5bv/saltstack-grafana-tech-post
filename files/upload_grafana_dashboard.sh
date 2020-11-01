#!/usr/bin/env bash

show_help_info () {
echo -e "\n\tERROR: $1"

cat <<HELPINFO

---
Usage:
    ./upload_grafana_dashboard.sh </path/to/dashboard.json>

Example:
    ./upload_grafana_dashboard.sh /root/local/grafana_dashboards/dashboard_single.json

HELPINFO
}

# -------------------------------------------------------------------------
if [ -z "$1" ];then
    show_help_info "No dashboard parameter received"
    exit 1
fi

# Get path/file parm
DASHBOARD=$1

# Pull through jq to validate json
payload="$(jq . ${DASHBOARD})  >> /root/grafana_upload.log"

# Upload the JSON to Grafana
# ( {{ api_auth }} and {{ api_server }} are rendered when this script is placed by Saltstack during installation
curl -X POST \
  -H 'Content-Type: application/json' \
  -d "${payload}" \
  "https://admin:{{ api_auth }}@{{ api_server }}/api/dashboards/db" -w "\n" >> /root/grafana_upload.log
