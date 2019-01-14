ddns-updater:
  pkg.installed:
    - name: curl
  file.managed:
    - name: /etc/systemd/system/ddns-updater.service
    - contents: |
        [Unit]
        Description=Dynamic DNS Updater
        Wants=network-online.target
        After=network-online.target

        [Service]
        EnvironmentFile=/etc/ddns-updater.conf
        ExecStart=/bin/sh -c 'ip="$${2:+$$(curl --ipv4 -sfL "$$2")}"; url="$${1}$${ip:+"&myip=$${ip}"}"; echo -n "request: $$url\nresponse: "; curl -sSL "$$url"' -- ${URL} ${IP_CHECK_URL}
        SyslogIdentifier=%p
    - makedirs: true
    - require:
      - pkg: curl
  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: ddns-updater

ddns-updater-config:
  file.managed:
    - name: /etc/ddns-updater.conf
    - contents: |
        #URL=https://[username]:[password]@domains.google.com/nic/update?hostname=[hostname]&myip=[public_ip]
        URL=https://{{ salt['pillar.get']('ddns:username') }}:{{ salt['pillar.get']('ddns:password') }}@domains.google.com/nic/update?hostname={{ salt['pillar.get']('ddns:host', grains.get('id')) }}.{{ salt['pillar.get']('ddns:domain') }}
        # if IP_CHECK_URL is specified, it will be used to determine the
        # public IP address of the host and appended to the update URL as '&myip=[public_ip]'
        IP_CHECK_URL=https://domains.google.com/checkip

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
    - watch:
      - file: ddns-updater
      - file: ddns-updater-config
