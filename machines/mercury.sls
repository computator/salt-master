gsettings-hidpi:
  file.managed:
    - name: /usr/share/glib-2.0/schemas/95_salt-hidpi.gschema.override
    - contents: |
        [com.ubuntu.user-interface]
        scale-factor={'eDP-1': 12}
    - onchanges_in:
      - cmd: gsettings-defaults
