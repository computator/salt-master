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
  file.replace:
    - name: /home/computator/.config/mimeapps.list
    - pattern: (text/(?:html|xml)|x-scheme-handler/(?:https?|ftp))=[^;]*?$
    - repl: \1=google-chrome-{{version}}.desktop
    - ignore_if_missing: true
