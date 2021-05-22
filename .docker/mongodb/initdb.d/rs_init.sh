set -Eeuo pipefail

#mongo --port=27017 <<EOF
#use admin
#db.createUser(
#  {
#    user: '$MONGO_INITDB_ROOT_USERNAME',
#    pwd: '$MONGO_INITDB_ROOT_PASSWORD',
#    roles: [ { role: "userAdminAnyDatabase", db: "admin" }, "readWriteAnyDatabase" ]
#  }
#) 
#EOF

#mongo --port=27017 -u "$MONGO_INITDB_ROOT_USERNAME" -p "$MONGO_INITDB_ROOT_PASSWORD" --authenticationDatabase admin "$MONGO_INITDB_DATABASE" <<EOF
#    db.createUser({
#        user: '$MONGO_INITDB_USERNAME',
#        pwd: '$MONGO_INITDB_PASSWORD',
#        roles: [ { role: 'readWrite', db: '$MONGO_INITDB_DATABASE' } ]
#    })
#EOF


#/usr/bin/sleep 10
#/usr/bin/mongo --host ${MONGODB1}:27017 -u "$MONGO_INITDB_ROOT_USERNAME" -p "$MONGO_INITDB_ROOT_PASSWORD" --authenticationDatabase admin "$MONGO_INITDB_DATABASE" <<EOF
#    db.createUser({
#        user: '$MONGO_INITDB_USERNAME',
#        pwd: '$MONGO_INITDB_PASSWORD',
#        roles: [ { role: 'readWrite', db: '$MONGO_INITDB_DATABASE' } ]
#    })
#EOF
