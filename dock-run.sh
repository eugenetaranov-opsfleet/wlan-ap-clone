#!/bin/bash -ex

tag=$(echo ${PWD} | tr / - | cut -b2- | tr A-Z a-z)
groups=$(id -G | xargs -n1 echo -n " --group-add ")
mkdir /tmp/bw-out
params="-v ${PWD}:${PWD} --rm -w ${PWD} -u"$(id -u):$(id -g)" $groups -v/etc/passwd:/etc/passwd -v/etc/group:/etc/group -v /tmp/bw-out:/tmp/bw-out ${tag}"

cd docker
docker build --tag=${tag} .
cd -

docker run $params $@
