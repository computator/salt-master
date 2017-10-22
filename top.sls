base:
  '*':
    - utilities
  'role:server':
    - match: grain
    - security
    - monitoring
    - ssh
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
  'L@desktop,mercury':
    - desktop
    - desktop.development

  {% for machine in salt['cp.list_states']() if machine.startswith('machines.') %}
  '{{ machine.split('.', 1)[1] }}':
    - {{ machine }}
  {% endfor %}