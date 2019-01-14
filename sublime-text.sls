sublime-text:
  cmd.run:
    - name: snap install --classic sublime-text > /dev/null
    - unless: snap list sublime-text

sublime-text-package-cotrol:
  file.managed:
    - name: /home/computator/.config/sublime-text-3/Installed Packages/Package Control.sublime-package
    - source: https://packagecontrol.io/Package%20Control.sublime-package
    - skip_verify: true
    - user: computator
    - group: computator
    - mode: 664
    - dir_mode: 700
    - makedirs: true
    - replace: false
    - show_changes: false
    - require:
      - cmd: sublime-text
