dconf-hidpi:
  file.managed:
    - name: /etc/dconf/db/local.d/10-salt-hidpi
    - contents: |
        [org/compiz/profiles/unity/plugins/core]
        hsize=2
        vsize=2
    - makedirs: true
    - onchanges_in:
      - cmd: dconf-defaults
