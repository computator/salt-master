base:
  '*':
    - utilities
    - ssh
    - ssh.sshpki
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
  'desktop':
    - ssh.server
  'L@desktop,mercury':
    - desktop
    - desktop.development

  {% for machine in salt['cp.list_states']() if machine.startswith('machines.') %}
  '{{ machine.split('.', 1)[1] }}':
    - {{ machine }}
  {% endfor %}
