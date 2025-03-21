FROM google/cloud-sdk:slim

RUN apt-get update && apt-get install -y wget

# Legger til Siste Postgres-versjon, Debian henger alltid en del etter
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN apt-get -y update && apt-get install -y \
    postgresql-client-14 \
    postgresql-contrib-14

RUN wget https://github.com/mikefarah/yq/releases/download/v4.45.1/yq_linux_amd64 -O /usr/local/bin/yq
RUN chmod 755 /usr/local/bin/yq

RUN wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O /usr/local/bin/cloud_sql_proxy
RUN chmod 755 /usr/local/bin/cloud_sql_proxy

RUN mkdir /db && chown 65532 /db
WORKDIR /db

ENV CLOUDSDK_CORE_CUSTOM_CA_CERTS_FILE /etc/ssl/ca-bundle.pem 
ENV HOME=/db

COPY files/bash/*.sh /etc/profile.d/

CMD ["sh", "-c", "tail -f /dev/null"]
