FROM ghcr.io/netbox-community/netbox:v4.4.8

RUN set -x \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt-get update -qq \
  && apt-get install -y git python3-pip \
  && rm -rf /var/lib/apt/lists/*

COPY netbox-proxbox /tmp/netbox-proxbox

RUN set -x \
  && . /opt/netbox/venv/bin/activate \
  && cd /tmp/netbox-proxbox \
  && pip3 install --break-system-packages . \
  && cd - \
  && rm -rf /tmp/netbox-proxbox

RUN set -x \
  && . /opt/netbox/venv/bin/activate \
  && pip3 install --break-system-packages git+https://github.com/mattieserver/netbox-topology-views@develop \
  && true
