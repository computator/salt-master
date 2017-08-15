minidlna:
  pkg.installed: []
  service.running: []
  file.comment:
    - name: /etc/minidlna.conf
    - regex: ^media_dir=/var/lib/minidlna$
    - require:
      - pkg: minidlna
    - watch_in:
      - service: minidlna

minidlna-config:
  file.blockreplace:
    - name: /etc/minidlna.conf
    - append_if_not_found: true