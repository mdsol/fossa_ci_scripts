# Travis CI FOSSA Setup Instructions

## Necessary Steps

- Add a `/.github/workflows/fossa.yml` with the following contents (or update an existing workflow file to include the `steps`):

```
name: Dependency License Scanning

on:
  pull_request:

defaults:
  run:
    shell: bash

jobs:
  fossa:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
      uses: actions/checkout@v2
    - name: Test for License Violations
      uses: mdsol/fossa_ci_scripts@main
      env:
        FOSSA_API_KEY: ${{ secrets.FOSSA_API_KEY }}
        FOSSA_BIN_DIR: "/usr/local/bin"
```

Note that `secrets.FOSSA_API_KEY` is configured as an organization secret, and should be accessible across all mdsol repos.
Fossa scripts will be installed under FOSSA_BIN_DIR, default value is `/usr/local/bin`. If using github-hosted agents, please change this directory to avoid permission issues.

## Optional Steps

### Failing Builds on Policy Violations
- By default, the action is designed to fail the build if there are policy violations. In order to scan without failing the build, add an `env` variable to the workflow YML named `FOSSA_FAIL_BUILD` and set its value to `false`. For example:
```
    - name: Test for License Violations (without failing the build)
      uses: mdsol/fossa_ci_scripts@main
      env:
        FOSSA_API_KEY: ${{ secrets.FOSSA_API_KEY }}
        FOSSA_FAIL_BUILD: false
```

### Pinning the FOSSA CLI version
- Add an environment variable to the Travis YML named `FOSSA_CLI_VERSION` and set its value to a valid semantic version for the FOSSA CLI.
  - __*Note*__: See the [FOSSA CLI GitHub Repository](https://github.com/fossas/fossa-cli/releases) for released versions.
