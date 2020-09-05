#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

DIR=$(pwd)

RUN_BOX="${DIR}/box"

echo "${RUN_BOX}";

mkdir -p "${RUN_BOX}"

cp -fv "${DIR}/Main.java" "${RUN_BOX}/Main.java"
echo "" > "${RUN_BOX}/run.stdin"

docker run \
    --cpus="0.5" \
    --memory="100m" \
    --ulimit nofile=64:64 \
    --rm \
    --read-only \
    -v "$RUN_BOX":/var/box \
    -w /var/box \
    ifaisalalam/ide-worker-java8 \
    bash -c "/bin/compile.sh && /bin/run.sh"

ls -lh "${RUN_BOX}"

expected="TLE: Execution exceeded the maximum timelimit."
actual="$(cat "${RUN_BOX}/tle.stderr")"

time_taken="$(< "${RUN_BOX}"/time.log tail -n 1)"

rm -rf "${RUN_BOX}"

echo "Time taken = $time_taken seconds."

if [[ "$expected" == "$actual" ]]; then
    echo "$DIR : TEST SUCCESS : Expected = $expected; Actual = $actual"
else
    echo "MISMATCH: Expected = $expected; Actual = $actual"
    exit 1
fi
