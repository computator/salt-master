samba:
  pkg.installed: []
  file.blockreplace:
    - name: /etc/samba/smb.conf
    - content: |
        [global]
        server min protocol = SMB2
        ;smb encrypt = desired
        lanman auth = no
        ntlm auth = no
    - append_if_not_found: true
    - require:
      - pkg: samba
    - watch_in:
      - service: samba
  service.running:
    - name: smbd
    - enable: true