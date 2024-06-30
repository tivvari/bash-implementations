#!/usr/bin/env bats

setup() {
  testdir=$(mktemp -d)
}

teardown() {
  rm -rf -- "$testdir"
}

@test "reads one line from stdin" {
  echo "asdf" >"${testdir}/in"
  ./bin/cat <"${testdir}/in" >"${testdir}/out"
  diff "${testdir}/in" "${testdir}/out"
}

@test "reads multiple lines from stdin" {
  echo "asdf" >"${testdir}/in"
  echo "qwerty" >>"${testdir}/in"
  echo "zxcvbn" >>"${testdir}/in"

  ./bin/cat <"${testdir}/in" >"${testdir}/out"

  diff "${testdir}/in" "${testdir}/out"
}

@test "read lines starting with whitespace" {
  echo "      alksjdfalskfda" >"${testdir}/in"

  ./bin/cat <"${testdir}/in" >"${testdir}/out"

  diff "${testdir}/in" "${testdir}/out"
}

@test "reads file from first argument" {
  echo "asdf" >"${testdir}/in"
  echo "zxcvbn" >>"${testdir}/in"

  ./bin/cat "${testdir}/in" >"${testdir}/out"

  diff "${testdir}/in" "${testdir}/out"
}

@test "reads stdin for -" {
  echo "asdf" >"${testdir}/in"
  echo "zxcvbn" >>"${testdir}/in"

  ./bin/cat - <"${testdir}/in" >"${testdir}/out"

  diff "${testdir}/in" "${testdir}/out"
}

@test "reads multiple files" {
  echo "asdf" >"${testdir}/in1"
  echo "qwerty" >>"${testdir}/in2"
  echo "zxcvbn" >>"${testdir}/in3"
  echo "asdf" >"${testdir}/expected"
  echo "qwerty" >>"${testdir}/expected"
  echo "zxcvbn" >>"${testdir}/expected"

  ./bin/cat "${testdir}/in1" "${testdir}/in2" "${testdir}/in3" >"${testdir}/out"

  diff "${testdir}/expected" "${testdir}/out"
}