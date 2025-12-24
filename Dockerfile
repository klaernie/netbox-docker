FROM ghcr.io/netbox-community/netbox:v4.4.9

RUN set -x \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt-get update -qq \
  && apt-get install -y git \
  && rm -rf /var/lib/apt/lists/*

COPY netbox-proxbox /tmp/netbox-proxbox

RUN set -x \
  && cd /tmp/netbox-proxbox \
  && /usr/local/bin/uv pip install . \
  && cd - \
  && rm -rf /tmp/netbox-proxbox

RUN set -x \
  && /usr/local/bin/uv pip install git+https://github.com/netbox-community/netbox-topology-views@develop \
  && true

COPY upstream-repo/configuration/configuration.py /etc/netbox/config/configuration.py
COPY plugins.py /etc/netbox/config/plugins.py
RUN DEBUG="true" SECRET_KEY="dummydummydummydummydummydummydummydummydummydummy" \
    /opt/netbox/venv/bin/python /opt/netbox/netbox/manage.py collectstatic --no-input
