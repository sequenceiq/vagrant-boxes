#!/bin/bash
curl -Lo /tmp/docker-functions http://j.mp/docker-functions && source /tmp/docker-functions
docker-kill-all
docker run -d -e SERF_JOIN_IP=192.168.38.10 --net=host --entrypoint /usr/local/serf/bin/start-serf-agent.sh sequenceiq/ambari:pam-fix
