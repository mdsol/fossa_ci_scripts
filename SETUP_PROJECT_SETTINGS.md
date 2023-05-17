# FOSSA Project Setup
A FOSSA Project is created on the first submission to FOSSA via the CLI Command `fossa analyze`.  If no `.fossa.yml` file is present (not recommended) in the directory that `fossa analyze` was run then the FOSSA CLI will attempt to auto-detect all of the necessary fields for submitting the Project Dependencies to FOSSA for analysis.  It is not recommended to use this approach since the FOSSA CLI will not generate a pretty/readable name for the Project and it is not guaranteed to detect all of the Prjoect Dependencies.  Instead it is recommended that teams follow the instructions below to create a `.fossa.yml` configuration file which is appropriate for their Project.

## Generate FOSSA CLI Configuration
The FOSSA CLI now provides a more sophisticated mechanism for detecting a project's dependencies and package managers.  It is possible that a `.fossa.yml` configuration file is not required for your project.  Please run `fossa analyze --output` on a local build and check if the unconfigured CLI provides sufficient coverage on your project, if not then read below regarding producing a `.fossa.yml` configuration file.

The FOSSA CLI no longer provides functionality to automatically generate the `.fossa.yml` file.  Instead this file must now be created by hand with the appropriate fields for the Project.  Documentation for the configuration file structure and fields can be found here : [https://github.com/fossas/fossa-cli/blob/master/docs/references/files/fossa-yml.md](https://github.com/fossas/fossa-cli/blob/master/docs/references/files/fossa-yml.md).

## Minimal Sample Configuration
```
version: 3

project:
  name: <Human Readable Project Name>
```
