FROM ubuntu:24.04@sha256:496754492fb28b4d3049432f2ca787449331e23fb14f0dd3fffea86bf5a93eb4

LABEL org.opencontainers.image.title="Sidera RunPod runtime" \
      org.opencontainers.image.source="https://github.com/shadowharness/sidera-runpod-runtime"

# Build context contains this Dockerfile only. Formation code and all job/API/SSH
# keys are supplied per job, never committed to an image layer.
RUN set -eu; \
    export DEBIAN_FRONTEND=noninteractive; \
    printf '#!/bin/sh\nexit 101\n' > /usr/sbin/policy-rc.d; \
    chmod 0755 /usr/sbin/policy-rc.d; \
    apt-get update -qq; \
    apt-get install -y -qq --no-install-recommends openssh-server ca-certificates curl xz-utils zstd util-linux python3; \
    rm -f /etc/ssh/ssh_host_*; \
    install -d -m 0755 /run/sshd /opt/sidera-node; \
    curl --fail --location --retry 3 --output /tmp/sidera-node.tar.xz https://nodejs.org/dist/v22.23.1/node-v22.23.1-linux-x64.tar.xz; \
    printf '%s\n' '9749e988f437343b7fa832c69ded82a312e41a03116d766797ac14f6f9eee578  /tmp/sidera-node.tar.xz' | sha256sum -c -; \
    tar -xJf /tmp/sidera-node.tar.xz --strip-components=1 -C /opt/sidera-node; \
    ln -s /opt/sidera-node/bin/node /usr/local/bin/node; \
    test "$(node --version)" = v22.23.1; \
    rm -f /tmp/sidera-node.tar.xz; \
    rm -rf /var/lib/apt/lists/*

EXPOSE 22
CMD ["/bin/bash"]
