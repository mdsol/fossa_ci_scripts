#!/usr/bin/env bash

install_fossa()
{
  FOSSA_BIN_DIR="${FOSSA_BIN_DIR:=/usr/local/bin}"
  url="https://raw.githubusercontent.com/fossas/fossa-cli/master/install-latest.sh"
  default_v3="v3.7.10"

  ret=1

  if [ "v3" = "$FOSSA_CLI_VERSION" ]; then
    # Backward compatibility branch for pre-existing usages
    echo "Installing FOSSA CLI v3 -> $default_v3"
    curl -H 'Cache-Control: no-cache' $url | bash -s -- -b $FOSSA_BIN_DIR $default_v3
  elif [ -n "$FOSSA_CLI_VERSION" ]; then
    echo "Installing FOSSA CLI v$FOSSA_CLI_VERSION"
    curl -H 'Cache-Control: no-cache' $url | bash -s -- -b $FOSSA_BIN_DIR v$FOSSA_CLI_VERSION
  else
    echo "Installing latest FOSSA CLI version"
    curl -H 'Cache-Control: no-cache' $url | bash -s -- -b $FOSSA_BIN_DIR
  fi
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

  fossa analyze
  result=$?
  if [ "${FOSSA_FAIL_BUILD:-true}" == "true" ]; then
    fossa test --timeout 600
    result=$?
    echo "fossa test result: $result"
  fi
  exit $result
}

install_fossa && run_fossa
