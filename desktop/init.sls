include:
  - google-chrome
  - deluge.gui

# remove transmission

vlc:
  pkg.installed: []
  cmd.run:
    - name: xdg-mime default vlc.desktop video/mp4 video/x-matroska
    - unless:
      - test "$(xdg-mime query default video/mp4)" = "vlc.desktop"
      - test "$(xdg-mime query default video/x-matroska)" = "vlc.desktop"
    - runas: computator
    - require:
      - pkg: vlc

gsettings-defaults:
  file.managed:
    - name: /usr/share/glib-2.0/schemas/50_salt-defaults.gschema.override
    - contents: |
        [org.compiz.unityshell]
        launcher-hide-mode=1

        [org.gnome.settings-daemon.plugins.media-keys]
        www='<Primary><Shift>b'

        [org.gtk.Settings.FileChooser]
        show-hidden=true

        [org.gnome.nautilus.preferences]
        default-folder-viewer='list-view'

        [org.gnome.nautilus.list-view]
        default-visible-columns=['name', 'size', 'type', 'date_modified', 'owner', 'group', 'permissions']
  cmd.run:
    - name: glib-compile-schemas /usr/share/glib-2.0/schemas
    - onchanges:
      - file: gsettings-defaults
