# GCP Functions Framework Playground

https://github.com/GoogleCloudPlatform/functions-framework-nodejs/tree/main
Typescript: https://github.com/GoogleCloudPlatform/functions-framework-nodejs/blob/main/docs/typescript.md

This project use `pnpm`, `typescript`, `terraform`

## Deployments

Deployments are done using terraform.

Execute `terraform apply` to deploy the application and update the cloud function code.

### How it works

Every non-sensitive and non-terraform file is zipped into an archive and deployed to a Google Cloud Storage (GCS) using the [cloud-function.tf - data "archive_file" "dist"](./cloud-function.tf) reference.

Once the file is uploaded, the google cloud function is updated with the new zip file.

**Note :warning:**: Terraform `main.tf` must be at same level as `src`, `package.json`, `dist`, etc... Having a directory terraform file in a subdirectory will result in terraform not being able to find the code to upload. Technically, every files must be under `path.module` for terraform cloud to be able to handle code source.
