#!/usr/bin/env bash

cd $(dirname "$0")

DIR=$(pwd)

RUN_BOX="${DIR}/box"

echo ${RUN_BOX};

mkdir -p ${RUN_BOX}

cp -fv ${DIR}/source.cpp ${RUN_BOX}/source.cpp
cp -fv ${DIR}/run.stdin ${RUN_BOX}/run.stdin

docker run \
    --cpus="0.5" \
    --memory="50m" \
    --ulimit nofile=64:64 \
    --rm \
    --read-only \
    -v "$RUN_BOX":/var/box \
    -w /var/box \
    ifaisalalam/ide-worker-cpp \
    bash -c "/bin/compile.sh && /bin/run.sh"

ls -lh ${RUN_BOX}

expected="Hello world"
actual="$(cat ${RUN_BOX}/run.stdout)"

rm -rf ${RUN_BOX}

if [[ "$expected" == "$actual" ]]; then
    echo "$DIR : TEST SUCCESS : Expected = $expected; Actual = $actual"
else
    echo "MISMATCH: Expected = $expected; Actual = $actual"
    exit 1
fi
