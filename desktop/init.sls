include:
  - google-chrome
  - deluge.gui

# remove transmission

vlc:
  pkg.installed
# set default

dconf-profile:
  file.managed:
    - name: /etc/dconf/profile/user
    - contents: |
        user-db:user
        system-db:local
    - makedirs: true
    - replace: false

dconf-defaults:
  file.managed:
    - name: /etc/dconf/db/local.d/10-salt-defaults
    - contents: |
        [org/compiz/profiles/unity/plugins/unityshell]
        launcher-hide-mode=1

        [org/gnome/settings-daemon/plugins/media-keys]
        www='<Primary><Shift>b'

        [org/gtk/settings/file-chooser]
        show-hidden=true

        [org/gnome/nautilus/preferences]
        default-folder-viewer='list-view'

        [org/gnome/nautilus/list-view]
        default-visible-columns=['name', 'size', 'type', 'date_modified', 'owner', 'group', 'permissions']
    - makedirs: true
  cmd.run:
    - name: dconf update
    - onchanges:
      - file: dconf-defaults
      - file: dconf-profile
