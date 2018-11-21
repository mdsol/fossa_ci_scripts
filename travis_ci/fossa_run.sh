#!/bin/bash

run_fossa()
{
  ./fossa
  fail_build_check
}

fail_build_check()
{
  # Check for Fail Build Toggle, default to false
  export FOSSA_FAIL_BUILD=${FOSSA_FAIL_BUILD:-false}
  # Get Toggle value in lowercase
  export FOSSA_FAIL_BUILD_TOGGLE=$(echo "$FOSSA_FAIL_BUILD" | tr '[:upper:]' '[:lower:]')

  # Check if Fail Build Toggle is Enabled
  if [ "$FOSSA_FAIL_BUILD_TOGGLE" == "true" ]; then
    # Return FOSSA CLI Exit Code for Build Failures
    export FOSSA_EXIT_CODE=$(./fossa test)
    exit $FOSSA_EXIT_CODE
  fi
}

# Check for Build Node Index
if [ -z $CI_NODE_INDEX ]; then
  # No Build Node Index provided; assume single thread (non-parallel) build, so run FOSSA
  run_fossa
else
  # Build Node Index provided, assume multi-thread (parallel) build; default to Node Index 0
  [[ $FOSSA_NODE_INDEX ]] || export FOSSA_NODE_INDEX=0

  # Check if Build Node Index is the FOSSA Node Index
  if [ $CI_NODE_INDEX -eq $FOSSA_NODE_INDEX ]; then
    # Only run FOSSA on FOSSA Node Index
    run_fossa
  fi
fi
