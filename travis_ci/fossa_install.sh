#!/bin/bash

BUILD_DIR="$TRAVIS_BUILD_DIR"
CLI_INSTALL_SCRIPT="https://raw.githubusercontent.com/fossas/fossa-cli/master/install.sh"

install_latest()
{
  echo "Installing Latest CLI Version..."
  if ! curl -H 'Cache-Control: no-cache' $CLI_INSTALL_SCRIPT | bash -s -- -b "$BUILD_DIR"; then
    echo "FOSSA CLI Install Failed :("
    exit 1
  fi
}

install_pinned()
{
  echo "Installing CLI Version $FOSSA_CLI_VERSION ..."
  if ! curl -H 'Cache-Control: no-cache' $CLI_INSTALL_SCRIPT | bash -s -- -b "$BUILD_DIR" v$FOSSA_CLI_VERSION; then
    echo "FOSSA CLI Install Failed :("
    exit 1
  fi
}

install_fossa()
{
  # Install FOSSA CLI via FOSSA provided Install Script
  # CLI is installed to Build Folder to avoid needing sudo access
  echo "Installing FOSSA CLI..." 
  if [ -z $FOSSA_CLI_VERSION ]; then
    install_latest
  else
    install_pinned
  fi

  echo "FOSSA CLI Installed Successfully!"
}

# Check for Build Node Index
if [ -z $CI_NODE_INDEX ]; then
  # No Build Node Index provided; assume single thread (non-parallel) build, so install CLI
  echo "Single Node Execution Detected..."
  install_fossa
else
  # Build Node Index provided; assume multi-thread (parallel) build; default to Node Index 0
  echo "Parallel Node Execution Detected..."
  [[ $FOSSA_NODE_INDEX ]] || export FOSSA_NODE_INDEX=0
  
  # Check if Build Node Index is the FOSSA Node Index
  if [ $CI_NODE_INDEX -eq $FOSSA_NODE_INDEX ]; then
    # Only install CLI on FOSSA Node Index
    install_fossa
  else
    echo "Current Node Index ($CI_NODE_INDEX) is not FOSSA Execution Node ($FOSSA_NODE_INDEX).  Skipping FOSSA Installation!"
  fi
fi
exit 0
