postfix:
  pkg.installed: []
  service.running:
    - enable: true
    - require:
      - pkg: postfix

mailutils:
  pkg.installed: []

postfix-listen-addrs:
  cmd.run:
    - name: postconf -e inet_interfaces=loopback-only
    - unless: test $(postconf -h inet_interfaces) = loopback-only
    - watch_in:
      - service: postfix

postfix-unset-networks:
  cmd.run:
    - name: postconf -e mynetworks=
    - unless: test -z $(postconf -h mynetworks)
    - watch_in:
      - service: postfix

postfix-set-networks-style:
  cmd.run:
    - name: postconf -e mynetworks_style=host
    - unless: test $(postconf -h mynetworks_style) = host
    - watch_in:
      - service: postfix

postfix-set-hostname:
  cmd.run:
    - name: postconf -e 'myhostname={{ grains.get('fqdn') }}'
    - unless: test "$(postconf -h myhostname)" = '{{ grains.get('fqdn') }}'
    - watch_in:
      - service: postfix

postfix-set-destination:
  cmd.run:
    - name: postconf -e 'mydestination=$myhostname, localhost'
    - unless: test "$(postconf -h mydestination)" = '$myhostname, localhost'
    - watch_in:
      - service: postfix
