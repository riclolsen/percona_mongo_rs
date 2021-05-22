# A mongodb replica set cluster for test and development of the JSON-SCADA project.

References
* https://github.com/sntnupl/devcontainers-mongodb-replica-set-with-docker
* https://jessequinn.info/blog/articles/mongo-docker

To execute:

    docker build -t mongo-replica-set .
    docker-compose up

To connect use the url as below:

    mongo mongodb://json_scada:json247scada@localhost:30001,localhost:30002,localhost:30003/json_scada?ssl=false
    
    mongo mongodb://admin:json0123admin@mongo1:30001,mongo2:30002,mongo3:30003/admin
    
You can change passwords on the ".env" file.
