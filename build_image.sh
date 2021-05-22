sudo chmod -R +r mongo1/
sudo chmod -R +x mongo1/
sudo chmod -R +r mongo2/
#docker build -t mongo-replica-set .
docker build . -f Dockerfile-mongodb -t ricardolo/json-scada-mongodb:latest
docker image push ricardolo/json-scada-mongodb-percona
