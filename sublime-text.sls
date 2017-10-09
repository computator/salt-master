sublime-text:
  pkgrepo.managed:
    - name: deb https://download.sublimetext.com/ apt/stable/
    - file: /etc/apt/sources.list.d/sublime-text.list
    - key_url: https://download.sublimetext.com/sublimehq-pub.gpg
    - require_in:
      - pkg: sublime-text
  pkg.installed:
    - name: sublime-text

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
      - pkg: sublime-text
