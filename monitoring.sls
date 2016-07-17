monitoring-packages:
  pkg.installed:
    - pkgs:
      - uptimed
      - sysstat

vnstat:
  pkg.installed: []
  cmd.wait:
    - name: vnstat -u -i {{ grains['ip_interfaces'].keys()|reject("equalto", "lo")|first }}
    - watch:
      - pkg: vnstat