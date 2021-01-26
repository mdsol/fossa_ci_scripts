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
    result=$(fossa test)
    echo "fossa test result: $result"
  fi
  exit $result
}

# DEPRECATION NOTICE
echo "******************************************************************"
echo "  NOTICE : THIS SCRIPT HAS BEEN PULLED FROM A DEPRECATED SOURCE"
echo "           PLEASE SEE :"
echo "  https://github.com/mdsol/fossa_ci_scripts/blob/main/github_actions/SETUP.md"
echo "******************************************************************"

# Randomly Fail the Build to enforce adoption of new branch name
#FAIL_BUILD=$(($RANDOM%10))
#if [ $FAIL_BUILD < 1 ]; then
#    exit 1
#fi

install_fossa && run_fossa
