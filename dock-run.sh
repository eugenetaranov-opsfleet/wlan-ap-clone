#!/bin/bash -ex

tag=$(echo ${PWD} | tr / - | cut -b2- | tr A-Z a-z)
groups=$(id -G | xargs -n1 echo -n " --group-add ")
mkdir /tmp/sonar-runner/
params="-v ${PWD}:${PWD} -v /tmp/sonar-runner:/home/runner --rm -w ${PWD} -u"$(id -u):$(id -g)" $groups -v/etc/passwd:/etc/passwd -v/etc/group:/etc/group -e SONAR_ORGANIZATION -e SONAR_PROJECT_KEY -e SONAR_URL -e SONAR_LOGIN ${tag}"

cd docker
docker build --tag=${tag} .
cd -

docker run $params $@
