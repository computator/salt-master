include:
  - virtualbox

{% set checkpoint = salt['cp.get_url']("https://checkpoint-api.hashicorp.com/v1/check/vagrant", None)|load_json %}

vagrant:
  pkg.installed:
    - sources:
      - vagrant: {{checkpoint['current_download_url']}}vagrant_{{checkpoint['current_version']}}_{% if grains['osarch'] == "amd64" %}x86_64{% else %}i686{% endif %}.{% if grains['os_family'] == "Debian" %}deb{% elif grains['os_family'] == "RedHat" %}rpm{% endif %}
    - unless:
      - dpkg-query -s vagrant 2> /dev/null | grep -q 'Status:.*installed'
      - dpkg-query -s vagrant 2> /dev/null | grep Version | grep -qF '{{checkpoint['current_version']}}'
