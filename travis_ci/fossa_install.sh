#!/bin/bash
install_fossa()
{
  # Install FOSSA CLI via FOSSA provided Install Script; CLI is installed to Build Folder to avoid needing sudo access
  curl -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/fossas/fossa-cli/master/install.sh | bash -s -- -b $TRAVIS_BUILD_DIR
}

# Check if Build Node Index is the FOSSA Node Index
if [ "${CI_NODE_INDEX-0}" -eq "${FOSSA_NODE_INDEX-0}" ]; then
  # Only install CLI on FOSSA Node Index
  install_fossa
fi
