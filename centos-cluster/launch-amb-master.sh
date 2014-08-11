#!/bin/bash

docker run -d -e SERF_JOIN_IP=192.168.38.11 --net=host --entrypoint /usr/local/serf/bin/start-serf-agent.sh  sequenceiq/ambari:pam-fix --tag ambari-server=true
