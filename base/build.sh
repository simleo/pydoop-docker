#!/usr/bin/env bash

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
this="${BASH_SOURCE-$0}"
this_dir=$(cd -P -- "$(dirname -- "${this}")" && pwd -P)

pushd "${this_dir}"
pv=${PYTHON_VERSION:-${TRAVIS_PYTHON_VERSION}}
docker build . \
  --build-arg hadoop_version=${HADOOP_VERSION} \
  --build-arg python_version=${pv} \
  -t crs4/pydoop-base:${HADOOP_VERSION}-${pv}
docker build . \
 -f Dockerfile.docs-base \
 -t crs4/pydoop-docs-base:${HADOOP_VERSION}-${pv}
popd
