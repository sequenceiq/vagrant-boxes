#!/bin/bash

function cbd_start() {
  cd /root/cbd_test
  cbd kill
  rm -v -f *.yml
  cbd generate
  cbd pull
  cbd startdb
  cbd migrate
  cbd start
}

function main() {
  cbd_start
}

main
