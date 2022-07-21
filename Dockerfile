FROM registry.access.redhat.com/ubi8/ubi-minimal:latest

ARG ETCD_VERSION=v3.4.19
LABEL name=etcd \
      vendor='Etcd community' \
      version=${ETCD_VERSION} \
      release='stable' \
      description='Etcd is an open-source, distributed key-value store' \
      summary='Etcd provides a consistent key-value store for shared configuration, service discovery, and scheduler coordination of distributed systems or clusters of machines'

ENV USER_ID=1009

WORKDIR /

ADD entrypoint.sh .

ADD LICENSE /licenses/apache2

RUN microdnf install curl tar gzip && \

curl -sLO https://github.com/etcd-io/etcd/releases/download/${ETCD_VERSION}/etcd-${ETCD_VERSION}-linux-amd64.tar.gz && \

tar xvfz etcd-${ETCD_VERSION}-linux-amd64.tar.gz -C /tmp --no-same-owner && \

chmod +x /tmp/etcd-${ETCD_VERSION}-linux-amd64/etcd* && \

mv  /tmp/etcd-${ETCD_VERSION}-linux-amd64/etcd* /usr/local/bin/ && \

rm -rf etcd-${ETCD_VERSION}-linux-amd64.tar.gz /tmp/etcd-${ETCD_VERSION}-linux-amd64/

USER ${USER_ID}

ENTRYPOINT ["./entrypoint.sh"]
