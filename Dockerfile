FROM ghcr.io/netbox-community/netbox
COPY topo.yaml '/run/config/extra/topo.yaml'
RUN /opt/netbox/venv/bin/pip install netbox-topology-views \
  && /opt/netbox/venv/bin/python3 /opt/netbox/netbox/manage.py collectstatic --no-input


