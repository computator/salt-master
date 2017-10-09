dkms:
  pkg.installed

virtualbox:
  pkgrepo.managed:
    - name: deb http://download.virtualbox.org/virtualbox/debian {{grains['oscodename']}} contrib
    - file: /etc/apt/sources.list.d/virtualbox.list
    - key_url: https://www.virtualbox.org/download/oracle_vbox{% if (grains['os'] == "Ubuntu" and grains['osmajorrelease'] >= 16) or (grains['os'] == "Debian" and grains['osmajorrelease'] >= 8) %}_2016{% endif %}.asc
    - require_in:
      - pkg: virtualbox
  pkg.installed:
    - name: virtualbox-5.1
    - require:
      - pkg: dkms
