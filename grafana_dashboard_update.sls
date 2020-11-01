# Author: Gerard Petersen (gerard@cap5.nl)

{% if 'tigserver' in pillar['servers'][ grains['host'] ].get('roles') %}

{% set stack_name = 'stack_tig' %}

# {{ servertype }} is defined because it results in different log locations.
{% for wpsite,data in pillar['wpc']['sites'].iteritems() %}
{{ sls }} - Render dashboard for {{ wpsite }}:
  file.managed:
    - name: /root/local/grafana_dashboards/dashboard_website_{{ wpsite }}.json
    - source: salt://{{ stack_name }}/grafana/files/dashboard_single_website.json
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - contents:
      wpsite: {{ wpsite }}
      {% if 'apache2' in pillar['servers'][ data['node'] ].get('services', []) %}
      servertype: apache2
      {% else %}
      servertype: nginx
      {% endif %}

{{ sls }} - Upload dashboard.json to Grafana for {{ wpsite }}:
  cmd.run:
    - name: /root/scripts/upload_grafana_dashboard.sh /root/local/grafana_dashboards/dashboard_website_{{ wpsite }}.json

{% endfor %}

{% endif %}
