FROM ghcr.io/netbox-community/netbox
RUN /opt/netbox/venv/bin/pip install \
  netbox-topology-views


