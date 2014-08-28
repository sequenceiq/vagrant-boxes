#!/bin/bash

#Setting up the ubuntu cluster
cd cluster
vagrant up

#Launching dockers
cd ..
vagrant up --provider=docker

#Install cluster
./install-hadoop-cluster.sh