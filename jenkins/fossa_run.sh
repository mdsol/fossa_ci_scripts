#!/bin/bash

run_fossa()
{
  echo "Queuing FOSSA Checks..."
  if ./fossa; then
    echo "FOSSA Checks Queued Successfully!"  
    fail_build_check
  else
    echo "FOSSA Checks Failed to Queue :("
    
    # Build Failure Disabled due to FOSSA Stability issue around token permission (1/21/2021); re-enable once stability restored
    # exit 1
    exit 0
  fi
}

fail_build_check()
{
  echo "Determining FOSSA Fail Build Flag..."
  
  # Check for Fail Build Toggle, default to false
  export FOSSA_FAIL_BUILD=${FOSSA_FAIL_BUILD:-false}
  # Get Toggle value in lowercase
  export FOSSA_FAIL_BUILD_TOGGLE=$(echo "$FOSSA_FAIL_BUILD" | tr '[:upper:]' '[:lower:]')

  # Check if Fail Build Toggle is Enabled
  if [ "$FOSSA_FAIL_BUILD_TOGGLE" == "true" ]; then
    # Return FOSSA CLI Exit Code for Build Failures
    echo "FOSSA Fail Build Flag Enabled.  Checking for Policy Violations..."
    export FOSSA_EXIT_CODE=$(./fossa test)
    echo "FOSSA Policy Violations check returned : $FOSSA_EXIT_CODE (non-zero codes are failures)"
    exit $FOSSA_EXIT_CODE
  else
    echo "FOSSA Fail Build Flag Disabled.  Skipping Policy Violations Check!"
  fi
}

# Check for Build Node Index
if [ -z $CI_NODE_INDEX ]; then
  # No Build Node Index provided; assume single thread (non-parallel) build, so run FOSSA
  echo "Single Node Execution Detected..."
  run_fossa
else
  # Build Node Index provided, assume multi-thread (parallel) build; default to Node Index 0
  echo "Parallel Node Execution Detected..."
  [[ $FOSSA_NODE_INDEX ]] || export FOSSA_NODE_INDEX=0

  # Check if Build Node Index is the FOSSA Node Index
  if [ $CI_NODE_INDEX -eq $FOSSA_NODE_INDEX ]; then
    # Only run FOSSA on FOSSA Node Index
    run_fossa
  else
    echo "Current Node Index ($CI_NODE_INDEX) is not FOSSA Execution Node ($FOSSA_NODE_INDEX).  Skipping FOSSA Execution!"
  fi
fi
exit 0
