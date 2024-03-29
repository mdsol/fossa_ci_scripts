# Travis CI FOSSA Setup Instructions

## Necessary Steps
- Request a Travis Admin (see #travis-ci Slack Channel) to add the FOSSA API key to your Travis project
- Edit the Travis YML (`.travis.yml`) exactly as it appears below:
  - Add to the `install` section:
  ```
  - >-
    curl -H 'Cache-Control: no-cache'
    https://raw.githubusercontent.com/mdsol/fossa_ci_scripts/main/travis_ci/fossa_install.sh |
    bash -s -- -b $TRAVIS_BUILD_DIR
  ```
  - Add to the `script` section:
  ```
  - >-
    curl -H 'Cache-Control: no-cache'
    https://raw.githubusercontent.com/mdsol/fossa_ci_scripts/main/travis_ci/fossa_run.sh |
    bash -s -- -b $TRAVIS_BUILD_DIR
  ```
- Follow any of the [optional steps](#optional-steps) found below
- Follow the necessary steps to [setup FOSSA Project Settings](/SETUP_PROJECT_SETTINGS.md)
- Commit & push changes to GitHub
- Open a pull request against a Travis CI monitored branch
- Check the Travis CI project run for errors or failures
- Merge the pull request when satisfied with the output

## Optional Steps

### Add FOSSA API Key to Travis Project
- Log into Travis CI and open the appropriate project
- Click "More Options" → "Settings" on the right side of the project page
- Add an environment variable named `FOSSA_API_KEY`, set its value to the provided API key, and set "Display value in log" to "Disabled"

### Parallelized Builds
- Add an environment variable to the Travis YML named `FOSSA_NODE_INDEX` and set its value to the node index which should execute the tasks.
  - __*Note*__: Scripts expect the executing node index to be stored in an environment variable called `CI_NODE_INDEX`. If this environment variable does not exist then the scripts will assume that no parallelization is taking place and the tasks will be executed on every node. This is not recommended and can muddy the results of the evaluation.

### Failing Builds on Policy Violations
- Add an environment variable to the Travis YML named `FOSSA_FAIL_BUILD` and set its value to `true`.
  - __*Note*__: This functionalily is optional at this time (May 2022), but will be made mandatory through script updates in the future. This toggle is a courtesy for teams which want to get a head start on these requirements.

### Pinning the FOSSA CLI version
- Add an environment variable to the Travis YML named `FOSSA_CLI_VERSION` and set its value to a valid semantic version for the FOSSA CLI.
  - __*Note*__: See the [FOSSA CLI GitHub Repository](https://github.com/fossas/fossa-cli/releases) for released versions.
