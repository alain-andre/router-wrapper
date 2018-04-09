#!/bin/sh

ROUTER=$1
GRAPHS_DIR=/srv/otp/data/graphs
DOCKER_DIR=/srv/docker

set -e

cd ../
echo $(pwd)

case ${ROUTER} in
  (marseille)
    echo "Cleanup old marseille ZIP files."
    rm -vf ${GRAPHS_DIR}/${ROUTER}/*.ZIP
    ;;
esac

echo "Cleanup old GTFS files."
rm -vf ${GRAPHS_DIR}/${ROUTER}/*-gtfs.zip

echo "Generate graph."
echo "docker-compose --project-directory ${DOCKER_DIR}/ --project-name router run --rm --entrypoint $(which make) otp-${ROUTER} -C ${GRAPHS_DIR}/${ROUTER}/"
docker-compose --project-directory ${DOCKER_DIR}/ --project-name router run --rm --entrypoint $(which make) otp-${ROUTER} -C ${GRAPHS_DIR}/${ROUTER}/

echo "Wait 10 seconds before reloading graphe."
sleep 10

echo "Reload graph."
PORT=$(docker inspect router_otp-${ROUTER}_1 | jq -r '.[0].NetworkSettings.Ports["7000/tcp"][0].HostPort')
curl -X PUT http://localhost:${PORT}/otp/routers/${ROUTER}

#docker-compose --project-directory /srv/docker --project-name router restart otp-${ROUTER}
