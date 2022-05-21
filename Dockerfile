FROM ghcr.io/netbox-community/netbox
COPY netbox-proxbox /tmp/netbox-proxbox
RUN set -x \
  && source /opt/netbox/venv/bin/activate \
  && cd /tmp/netbox-proxbox \
  && pip3 install build \
  && python3 -m build \
  && pip3 install dist/*.whl \
  && pip3 install requests pynetbox paramiko proxmoxer \
  && cd - \
  && rm -rf /tmp/netbox-proxbox \
  && SITEDIR=$(/opt/netbox/venv/bin/python3 -c 'import site; print(site.getsitepackages()[0])') \
  && sed -i "/^TEMPLATES_DIR =/a PROXBOX_TEMPLATE_DIR = BASE_DIR + '/netbox-proxbox/netbox_proxbox/templates/netbox_proxbox'" /opt/netbox/netbox/netbox/settings.py \
  && sed -i "s|'DIRS': \[TEMPLATES_DIR\],|'DIRS': [TEMPLATES_DIR, PROXBOX_TEMPLATE_DIR],|" /opt/netbox/netbox/netbox/settings.py \
  && /opt/netbox/venv/bin/pip install netbox-topology-views \
  && cp -r $SITEDIR/netbox_topology_views/static/netbox_topology_views /opt/netbox/netbox/static/ \
  && true


