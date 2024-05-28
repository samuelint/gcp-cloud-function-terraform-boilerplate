# GCP Functions Framework Playground

https://github.com/GoogleCloudPlatform/functions-framework-nodejs/tree/main
Typescript: https://github.com/GoogleCloudPlatform/functions-framework-nodejs/blob/main/docs/typescript.md

This project use `pnpm`, `typescript`

## Deployments

Deployments are done using terraform

:warning: Terraform `main.tf` must be at same level as `dist` directory. Having a directory `./terraform` will result in terraform cloud to not be able to access gcp function file.
