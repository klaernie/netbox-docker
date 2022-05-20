FROM ghcr.io/netbox-community/netbox
COPY topo.yaml '/run/config/extra/topo/topo.yaml'
COPY netbox-proxbox /tmp/netbox-proxbox
RUN set -x \
  && source /opt/netbox/venv/bin/activate \
  && cd /tmp/netbox-proxbox \
  && python3 setup.py develop \
  && cd - \
  && rm -rf /tmp/netbox-proxbox \
  && /opt/netbox/venv/bin/pip install netbox-topology-views \
  && cp -r /opt/netbox/venv/lib/python3.9/site-packages/netbox_topology_views/static/netbox_topology_views /opt/netbox/netbox/static/ \
  true


