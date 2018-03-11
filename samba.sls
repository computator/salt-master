samba:
  pkg.installed: []
  service.running:
    - name: smbd
    - enable: true