FROM container-registry.oracle.com/os/oraclelinux:9-slim
# hadolint ignore=DL3041
RUN microdnf -y install python3 pip \
  && microdnf clean all \
  && rm -rf /var/cache
COPY requirements.txt /requirements.txt
RUN pip3 install --no-cache-dir -r /requirements.txt
