# Author: Gerard Petersen (gerard@cap5.nl)

{% set stack_name = 'stack_tig' %}

{% if 'tigserver' in pillar['servers'][ grains['host'] ].get('roles') %}

# Make sure necessary dirs are present
root local directory:
  file.directory:
    - name: /root/local
    - user: root
    - group: root
    - mode: 0755


/root/scripts/upload_grafana_dashboard.sh:
  file.managed:
    - source: salt://{{ stack_name }}/grafana/files/upload_grafana_dashboard.sh
    - template: jinja
    - user: root
    - group: root
    - mode: 744
    - contents:
      api_server: {{ pillar['servers'][ grains['host'] ]['tig_stack']['grafana']['api_server'] }}
      api_auth: {{ pillar['servers'][ grains['host'] ]['tig_stack']['grafana']['api_auth'] }}

{% endif %}
