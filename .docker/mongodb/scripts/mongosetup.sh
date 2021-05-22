#!/bin/bash
set -Eeuo pipefail

MONGODB1=mongo1
MONGODB2=mongo2
MONGODB3=mongo3

echo "**********************************************" ${MONGODB1}
echo "Waiting for startup.."
sleep 15
echo "done"

#mongo --host ${MONGODB1}:27017 <<EOF
#use admin
#db.createUser(
#  {
#    user: '$MONGO_INITDB_ROOT_USERNAME',
#    pwd: '$MONGO_INITDB_ROOT_PASSWORD',
#    roles: [ { role: "userAdminAnyDatabase", db: "admin" }, "readWriteAnyDatabase" ]
#  }
#) 
#EOF
#

sleep 4

echo SETUP.sh time now: `date +"%T" `
# mongo --host ${MONGODB1}:27017 -u ${MONGO_INITDB_ROOT_USERNAME} -p ${MONGO_INITDB_ROOT_PASSWORD} <<EOF

/usr/bin/mongo  --host ${MONGODB1}:27017 <<EOF
var cfg = {
    "_id": "rs1",
    "protocolVersion": 1,
    "version": 1,
    "writeConcernMajorityJournalDefault": false,
    "members": [
        {
            "_id": 0,
            "host": "mongo1:27017",
            "priority": 2
        },
        {
            "_id": 1,
            "host": "mongo2:27017",
            "votes": 0,
            "priority": 0,
            //"slaveDelay" : <seconds>,
            "hidden" : true
        }
    ]
};
rs.initiate(cfg, { force: true });
rs.secondaryOk();
db.getMongo().setReadPref('primary');
rs.status();
EOF

#mongo --host ${MONGODB1}:27017 -u "$MONGO_INITDB_ROOT_USERNAME" -p "$MONGO_INITDB_ROOT_PASSWORD" --authenticationDatabase admin "$MONGO_INITDB_DATABASE" <<EOF
#    db.createUser({
#        user: '$MONGO_INITDB_USERNAME',
#       pwd: '$MONGO_INITDB_PASSWORD',
#        roles: [ { role: 'readWrite', db: '$MONGO_INITDB_DATABASE' } ]
#    })
#EOF

mongo --host ${MONGODB1}:27017    ${MONGO_INITDB_DATABASE} < /mongo_seed/b_create-db.js
mongoimport -h ${MONGODB1}:27017  -d ${MONGO_INITDB_DATABASE} -c realtimeData --type json --file /mongo_seed/demo_data.json 
mongoimport -h ${MONGODB1}:27017  -d ${MONGO_INITDB_DATABASE} -c roles --type json --file /mongo_seed/roles.json 
mongoimport -h ${MONGODB1}:27017  -d ${MONGO_INITDB_DATABASE} -c users --type json --file /mongo_seed/users.json 
mongoimport -h ${MONGODB1}:27017  -d ${MONGO_INITDB_DATABASE} -c processInstances --type json --file /mongo_seed/demo_process_instances.json
mongoimport -h ${MONGODB1}:27017  -d ${MONGO_INITDB_DATABASE} -c protocolDriverInstances --type json --file /mongo_seed/demo_instances.json
mongoimport -h ${MONGODB1}:27017  -d ${MONGO_INITDB_DATABASE} -c protocolConnections --type json --file /mongo_seed/demo_connections.json 
