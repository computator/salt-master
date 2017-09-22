base:
  '*':
    - common
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
