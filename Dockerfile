FROM ghcr.io/netbox-community/netbox
RUN /opt/netbox/venv/bin/pip install netbox-topology-views \
  && echo 'PLUGINS: ["netbox_topology_views"]' >'/run/config/extra/topo.yaml' \
  && /opt/netbox/venv/bin/python3 /opt/netbox/netbox/manage.py collectstatic --no-input


