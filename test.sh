#!/usr/bin/env bats

@test "test cpp" {
    bash tests/cpp/test_worker.sh
}

@test "test c" {
    bash tests/c/test_worker.sh
}

@test "test cpp-timeout" {
    bash tests/cpp-timeout/test_worker.sh
}

@test "test c-timeout" {
    bash tests/c-timeout/test_worker.sh
}

@test "test python2" {
  bash tests/python2/test_worker.sh
}

@test "test python2-timeout" {
  bash tests/python2-timeout/test_worker.sh
}

@test "test python3" {
  bash tests/python3/test_worker.sh
}

@test "test python3-timeout" {
  bash tests/python3-timeout/test_worker.sh
}

@test "test java8" {
  bash tests/java8/test_worker.sh
}

@test "test java8-timeout" {
  bash tests/java8-timeout/test_worker.sh
}
