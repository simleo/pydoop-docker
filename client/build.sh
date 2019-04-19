#!/usr/bin/env bash

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
this="${BASH_SOURCE-$0}"
this_dir=$(cd -P -- "$(dirname -- "${this}")" && pwd -P)

pushd "${this_dir}"
pv=${PYTHON_VERSION:-${TRAVIS_PYTHON_VERSION}}
docker build . \
  -f Dockerfile.base \
  --build-arg hadoop_version=${HADOOP_VERSION} \
  --build-arg python_version=${pv} \
  -t crs4/pydoop-client-base:${HADOOP_VERSION}-${pv}
popd
