#!/bin/sh

ROUTER=$1
GRAPHS_DIR=/srv/otp/data/graphs

set -e

# echo "Clean graph."
# docker-compose --project-directory ../ --project-name router run --rm --entrypoint make otp-${ROUTER} clean

echo "Generate graph."
echo "docker-compose --project-directory ../ --project-name router run --rm --entrypoint make otp-${ROUTER} -C ${GRAPHS_DIR}/${ROUTER}/"
docker-compose --project-directory ../ --project-name router run --rm --entrypoint make otp-${ROUTER} -C ${GRAPHS_DIR}/${ROUTER}/

echo "Wait 10 seconds before reloading graphe."
sleep 10

echo "Reload graph."
PORT=$(docker inspect router_otp-${ROUTER}_1 | jq -r '.[0].NetworkSettings.Ports["7000/tcp"][0].HostPort')
curl -X PUT http://localhost:${PORT}/otp/routers/${ROUTER}
