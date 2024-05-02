FROM ghcr.io/netbox-community/netbox:v3.7.7
COPY netbox-proxbox /tmp/netbox-proxbox
RUN set -x \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt-get update -qq \
  && apt-get install -y git \
  && rm -rf /var/lib/apt/lists/* \
  && . /opt/netbox/venv/bin/activate \
  && cd /tmp/netbox-proxbox \
  && pip3 install build virtualenv \
  && python3 -m build \
  && pip3 install dist/*.whl \
  && pip3 install requests pynetbox paramiko proxmoxer \
  && cd - \
  && rm -rf /tmp/netbox-proxbox \
  && SITEDIR=$(/opt/netbox/venv/bin/python3 -c 'import site; print(site.getsitepackages()[0])') \
#  && sed -i "/^TEMPLATES_DIR =/a PROXBOX_TEMPLATE_DIR = '$SITEDIR/netbox_proxbox/templates/netbox_proxbox'" /opt/netbox/netbox/netbox/settings.py \
#  && sed -i "s|'DIRS': \[TEMPLATES_DIR\],|'DIRS': [TEMPLATES_DIR, PROXBOX_TEMPLATE_DIR],|" /opt/netbox/netbox/netbox/settings.py \
  && /opt/netbox/venv/bin/pip install git+https://github.com/mattieserver/netbox-topology-views@develop \
  && cp -r $SITEDIR/netbox_topology_views/static/netbox_topology_views /opt/netbox/netbox/static/ \
  && true


