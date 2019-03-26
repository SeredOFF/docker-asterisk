#!/usr/bin/env bash

docker run -td \
    -p 5060:5060/udp \
    -p 5060:5060/tcp \
    -p 5061:5061/udp \
    -p 5061:5061/tcp \
    -p 10000-10099:10000-10099/udp \
    -p 8088:8088/tcp \
    -p 8089:8089/tcp \
    -p 3478:3478/udp \
    -p 3478:3478/tcp \
    -p 19302:19302/udp \
    -p 19302:19302/tcp \
    --name aster \
    dseredov/docker-asterisk:15.7
