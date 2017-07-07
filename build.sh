#!/bin/bash -x

ID=$(docker build -q -t falconmfm/docker-centos-oracle-java .)

docker tag $ID falconmfm/docker-centos-oracle-java:0.0.1
