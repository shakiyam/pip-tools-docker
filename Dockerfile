FROM ghcr.io/oracle/oraclelinux:9-slim
# hadolint ignore=DL3041
RUN microdnf -y install python3.12 python3.12-pip \
  && microdnf clean all \
  && rm -rf /var/cache
COPY requirements.txt /requirements.txt
# TODO: Remove the pip constraint when jazzband/pip-tools#2437 is resolved
# hadolint ignore=DL3013
RUN python3.12 -m pip install --no-cache-dir --upgrade 'pip<26.2' && python3.12 -m pip install --no-cache-dir -r /requirements.txt
