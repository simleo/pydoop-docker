#!/usr/bin/env bash

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

img_list=(
    pydoop-client-base
)

echo "${CI_PASS}" | docker login -u "${CI_USER}" --password-stdin

pv=${PYTHON_VERSION:-${TRAVIS_PYTHON_VERSION}}
for img in "${img_list[@]}"; do
    docker push crs4/${img}:${HADOOP_VERSION}-${pv}
    if [ -n "${LATEST:-}" ]; then
	docker tag crs4/${img}:${HADOOP_VERSION}-${pv} crs4/${img}:latest
	docker push crs4/${img}:latest
    fi
done
