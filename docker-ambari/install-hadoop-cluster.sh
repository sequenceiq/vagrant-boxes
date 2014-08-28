#!/bin/bash


export JAR_PATH=ambari-shell.jar
curl -Ls https://raw.githubusercontent.com/sequenceiq/ambari-shell/master/latest-snap.sh | bash

: ${AMBARI_HOST:=192.168.38.10}
: ${BLUEPRINT:=multi-node-hdfs-yarn}


java -jar ambari-shell.jar --ambari.host=$AMBARI_HOST << EOF
blueprint defaults
cluster build --blueprint $BLUEPRINT
cluster autoAssign
cluster create --exitOnFinish true
EOF
