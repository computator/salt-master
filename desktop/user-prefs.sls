{% load_yaml as settings %}
org.gnome.shell:
  favorite-apps: "['org.gnome.Nautilus.desktop', 'google-chrome-unstable.desktop', 'sublime-text_subl.desktop', 'vlc.desktop', 'deluge.desktop']"
org.gnome.shell.extensions.dash-to-dock:
  dock-fixed: 'false'
  dash-max-icon-size: 32
{% endload %}

{% for schema, values in settings.iteritems() %}
{% for key, value in values.iteritems() %}
gsettings-setting_{{schema}}_{{key}}:
  cmd.run:
    - name: gsettings set '{{schema}}' '{{key}}' "{{value}}"
    - unless:
      - test "$(gsettings get '{{schema}}' '{{key}}')" = "{{value}}"
    - runas: computator
{% endfor %}
{% endfor %}


{% load_yaml as term_settings %}
use-theme-transparency: 'false'
use-transparent-background: 'true'
background-transparency-percent: 20
use-system-font: 'false'
font: "'Monospace 8'"
scrollback-unlimited: 'true'
{% endload %}

{% set profile_id = salt.cmd.run('gsettings get org.gnome.Terminal.ProfilesList default', runas='computator').strip("'") %}
{% for key, value in term_settings.iteritems() %}
gsettings-term-setting_{{key}}:
  cmd.run:
    - name: gsettings set 'org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:{{profile_id}}/' '{{key}}' "{{value}}"
    - unless:
      - test "$(gsettings get 'org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:{{profile_id}}/' '{{key}}')" = "{{value}}"
    - runas: computator
{% endfor %}
