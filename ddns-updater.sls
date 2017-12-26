ddns-updater:
  file.managed:
    - name: /etc/systemd/system/ddns-updater.service
    - contents: |
        [Unit]
        Description=Dynamic DNS Updater
        Wants=network-online.target
        After=network-online.target

        [Service]
        EnvironmentFile=/etc/ddns-updater.conf
        ExecStart=/usr/bin/curl -sSfL '$URL'
        SyslogIdentifier=%p
    - makedirs: true

ddns-updater-config:
  file.managed:
    - name: /etc/ddns-updater.conf
    - contents: |
        #URL=https://dynamicdns.park-your-domain.com/update?host=[host]&domain=[domain_name]&password=[ddns_password]&ip=[your_ip]
        URL=https://dynamicdns.park-your-domain.com/update?host={{ salt['pillar.get']('ddns:host', grains.get('id')) }}&domain={{ salt['pillar.get']('ddns:domain') }}&password={{ salt['pillar.get']('ddns:password') }}

ddns-updater-timer:
  file.managed:
    - name: /etc/systemd/system/ddns-updater.timer
    - contents: |
        [Unit]
        Description=Timer to run Dynamic DNS Updater

        [Timer]
        OnBootSec=1m
        OnUnitActiveSec=1h

        [Install]
        WantedBy=timers.target
    - makedirs: true
    - require:
      - file: ddns-updater
  service.running:
    - name: ddns-updater.timer
    - enable: true
    - require:
      - file: ddns-updater-timer
      - file: ddns-updater-config
