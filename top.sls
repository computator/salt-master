base:
  '*':
    - utilities
    - ssh
    - sshpki
  'role:server':
    - match: grain
    - security
    - monitoring
    - ssh.server
    - postfix
  'role:seedbox':
    - match: grain
    - deluge
    - deluge.yarss
    - deluge.vpn
    # - videos_mount
  'role:mercurial-server':
    - match: grain
    - mercurial
    - mercurial.ssh-server
  'monolith':
    - nas
    - mercurial.ssh-server
  'L@desktop,ephemeris':
    - ssh.server
  'L@monolith,desktop':
    - ddns-updater
  'L@desktop,mercury,ephemeris':
    - desktop
  'L@desktop,mercury':
    - desktop.development

  {% for machine in salt['cp.list_states']() if machine.startswith('machines.') %}
  '{{ machine.split('.', 1)[1] }}':
    - {{ machine }}
  {% endfor %}
