#!/bin/bash
run_fossa()
{
  # Run FOSSA Policy Checks and get the resulting Exit Code
  fossa
  fossa test
  FOSSA_EXIT_CODE=$?
}

# Check if Build Node Index is the FOSSA Node Index
if [ "${CI_NODE_INDEX-0}" -eq "${FOSSA_NODE_INDEX-0}" ]; then
  # Only run FOSSA on FOSSA Node Index
  run_fossa
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
