#!/usr/bin/env bash

install_fossa()
{
  echo "Installing FOSSA CLI $FOSSA_VERSION"
  FOSSA_BIN_DIR="${FOSSA_BIN_DIR:=/usr/local/bin}"
  url="https://raw.githubusercontent.com/fossas/fossa-cli/master/install-latest.sh"

  if [ $FOSSA_VERSION == "v1" ]; then
    url="https://raw.githubusercontent.com/fossas/fossa-cli/master/install.sh"
  fi

  curl -H 'Cache-Control: no-cache' $url | bash -s -- -b $FOSSA_BIN_DIR
  ret=$?
  if [ $ret -ne 0 ]; then
    echo 'Error: FOSSA install failed' >&2
    exit 1
  fi
}

run_fossa()
{
  echo "Analyzing and testing licenses..."
  FOSSA_BIN_DIR="${FOSSA_BIN_DIR:=/usr/local/bin}"
  export PATH=$PATH:$FOSSA_BIN_DIR

  if [ $FOSSA_VERSION == "v1" ]; then
    fossa init
  fi

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
