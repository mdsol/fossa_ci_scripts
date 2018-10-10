#!/bin/bash
run_fossa()
{
  # Run FOSSA Policy Checks and get the resulting Exit Code
  fossa test
  FOSSA_EXIT_CODE=$?
}

# Check for Build Node Index
if [ -z "$CI_NODE_INDEX" ]; then
  # No Build Node Index provided; assume single thread (non-parallel) build, so run FOSSA
  run_fossa
else
  # Build Node Index provided; assume multi-thread (parallel) build
  if [ -z "FOSSA_NODE_INDEX" ]; then
    # Set Default Build Node Index
    FOSSA_NODE_INDEX=0
  fi

  # Check if Build Node Index is the FOSSA Node Index
  if [ "$CI_NODE_INDEX" -eq "$FOSSA_NODE_INDEX" ]; then
    # Only run FOSSA on FOSSA Node Index
    run_fossa
  fi
fi

# Check for Fail Build Toggle
if [ -z "$FOSSA_FAIL_BUILD" ]; then
  # Get Toggle value in lowercase
  FAIL_BUILD_TOGGLE=${FOSSA_FAIL_BUILD,,}
  
  # Check if Fail Build Toggle is Enabled
  if [ "$FAIL_BUILD_TOGGLE" -eq "true" ]; then
    # Return FOSSA CLI Exit Code for Build Failures
    exit $FOSSA_EXIT_CODE
  fi
fi
