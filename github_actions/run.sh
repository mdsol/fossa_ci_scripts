#!/usr/bin/env bash

install_fossa()
{
  echo "Installing FOSSA CLI"
  curl -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/fossas/fossa-cli/master/install.sh | bash -s
  ret=$?
  if [ $ret -ne 0 ]; then
    echo 'Error: FOSSA install failed' >&2
    exit 1
  fi
}

run_fossa()
{
  echo "Analyzing and testing licenses..."
  fossa init
  fossa analyze
  result=$?
  if [ "${FOSSA_FAIL_BUILD:-true}" == "true" ]; then
    fossa test
    result=$?
    echo "fossa test result: $result"
  fi
  exit $result
}

install_fossa && run_fossa
