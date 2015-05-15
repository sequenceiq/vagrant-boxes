#!/bin/bash

function cbd_start() {
  cd /root/cbd_test
  cbd kill
  cbd regenerate
  cbd pull
  cbd start
}

function main() {
  cbd_start
}

main
