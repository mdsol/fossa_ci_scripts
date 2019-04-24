#!/bin/bash

install_fossa__adds_fossa_cmd()
{
  echo "Test install_fossa__adds_fossa_cmd..."
  export TRAVIS_BUILD_DIR=${TRAVIS_BUILD_DIR:-`pwd`}
  echo "Info: TRAVIS_BUILD_DIR is $TRAVIS_BUILD_DIR"

  ../travis_ci/fossa_install.sh &> /dev/null 
  ret=$?
  echo "Info: fossa_install.sh exit code is $ret"
  if [ $ret -ne 0 ]; then
    echo 'Error: fossa_install.sh failed' >&2
    return 1
  fi

  if ! [ -x "$(command -v './fossa')" ]; then
    echo 'Error: fossa not installed' >&2
    return 1
  fi
  echo 'PASSED'
  return 0
}

run_fossa__fails_if_api_key_missing()
{
  echo "Test run_fossa__fails_if_api_key_missing..."

  ../travis_ci/fossa_run.sh &> /dev/null
  ret=$?
  echo "Info: fossa_run.sh exit code is $ret"
  if [ $ret -eq 0 ]; then
    echo 'Error: fossa_run.sh succeeded but should have failed' >&2
    return 1
  fi

  echo 'PASSED'
  return 0
}

TESTS_PASS=0
# add new tests here and follow pattern to exit with error if any fail
install_fossa__adds_fossa_cmd || TESTS_PASS=$?
run_fossa__fails_if_api_key_missing || TESTS_PASS=$?
exit $TESTS_PASS
