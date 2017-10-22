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
