nginx:
  pkgrepo.managed:
    {% if grains['os'] == "Ubuntu" %}
    - name: deb http://nginx.org/packages/ubuntu/ {{ grains['oscodename'] }} nginx
    - file: /etc/apt/sources.list.d/nginx.list
    - key_url: https://nginx.org/keys/nginx_signing.key
    {% elif grains['os'] == "CentOS" %}
    - baseurl: http://nginx.org/packages/centos/$releasever/$basearch/
    - gpgcheck: 0
    {% endif %}
    - require_in:
      - pkg: nginx
  pkg.installed:
    - name: nginx
  file.replace:
    - name: /etc/nginx/nginx.conf
    - pattern: ^worker_processes\s+\d+;$
    - repl: worker_processes {{ grains['num_cpus'] }};
    - count: 1
    - require:
      - pkg: nginx
  service.running:
    - enable: true
    - reload: true
    - require:
      - pkg: nginx
    - watch:
      - file: /etc/nginx/nginx.conf

nginx-disable-defconfig:
  file.rename:
    - name: /etc/nginx/conf.d/default.conf.dis
    - source: /etc/nginx/conf.d/default.conf
    - force: true
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx