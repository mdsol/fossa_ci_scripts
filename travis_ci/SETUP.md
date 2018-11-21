# Travis CI FOSSA Setup Instructions

## Necessary Steps
  - Open the Project's '.travis.yml' for editing
  - Add the following line to the Travis YML 'install' stage exactly as it appears below :  
  ```- |- 
       curl -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/Jman420/fossa_ci_scripts/develop/travis_ci/fossa_install.sh | bash -s -- -b $TRAVIS_BUILD_DIR```
  - Add the following line to the Travis YML 'script' stage exactly as it appears below :  
  ```- |- 
       curl -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/Jman420/fossa_ci_scripts/develop/travis_ci/fossa_run.sh | bash -s -- -b $TRAVIS_BUILD_DIR```
  - Commit & push changes to GitHub
  - Check TravisCI Project Pipeline for errors or failures

## Optional Steps

### Parallelized Builds
  - Add an Environment Variable to the Travis YML called 'FOSSA_NODE_INDEX' and set its value to the Node Index which should execute the tasks  
**_Note_** : Scripts expect the Executing Node Index to be stored in an Environment Variable called 'CI_NODE_INDEX'.  If this Environment Variable does not exist then the scripts will assume that no Parallelization is taking place and the tasks will be executed on every node.  This is not recommended and can muddy the results of the evaluation.

### Failing Builds on Policy Violations
  - Add an Environment Variable to the Travis YML called 'FOSSA_FAIL_BUILD' and set its value to 'true'  
**_Note_** : This functionalily is optional at this time (Nov 2018), but will be made manditory through script updates in the future.  This toggle is a courtesy for teams which want to get a head start on these requirements.
