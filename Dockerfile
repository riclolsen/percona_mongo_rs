 # {json:scada} Mongodb Percona docker container - (c) 2021 - Ricardo L. Olsen 
 
FROM percona/percona-server-mongodb:4.4

USER root

RUN yum install openssl -y
RUN yum install percona-server-mongodb-tools-${FULL_PERCONA_VERSION} -y

RUN mkdir -p /var/log/mongodb && mkdir -p /data/configdb
RUN chown 1001:1001 /var/log/mongodb

# Generate keyfile
RUN mkdir -p /data/key \
  && openssl rand -base64 756 > /data/key/replica-set.key

# Modify keyfile permissions
RUN chown 1001:1001 /data/key/replica-set.key \
  && chmod 400 /data/key/replica-set.key

#COPY ./demo-docker/mongors1/files /files
#COPY ./demo-docker/mongo_seed/files /docker-entrypoint-initdb.d

ENV MONGO_INITDB_DATABASE=json_scada
