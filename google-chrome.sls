{% set version = 'unstable' %}

google-chrome:
  pkgrepo.managed:
    - name: deb [arch={{grains['osarch']}}] http://dl.google.com/linux/chrome/deb stable main
    - file: /etc/apt/sources.list.d/google-chrome-{{version}}.list
    - key_url: https://dl-ssl.google.com/linux/linux_signing_key.pub
    - require_in:
      - pkg: google-chrome
  pkg.installed:
    - name: google-chrome-{{version}}

google-chrome-setdefault:
  cmd.run:
    - name: xdg-settings set default-web-browser google-chrome-{{version}}.desktop
    - unless: xdg-settings check default-web-browser google-chrome-{{version}}.desktop | grep -q yes
    - runas: computator
    - require:
      - pkg: google-chrome