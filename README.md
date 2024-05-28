# GCP Cloud Function Terraform Boilerplate

This project use `pnpm`, `typescript`, `terraform`

If you found this repository useful, please consider giving it a star ⭐️!

## How to use this boilerplate

1. Clone this repo `git clone git@github.com:samuelint/gcp-cloud-function-terraform-boilerplate.git`
2. Setup terraform cloud
   2.1 Terraform Cloud login - https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-login
   2.2 GCP + Terraform Cloud Auth - https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#running-terraform-on-google-cloud
3. Set Terraform cloud workspace id in `main.tf` (https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-workspace-create)

4. `terraform plan`, `terraform apply` 🚀

## Deployments

Deployments are done using terraform.
Execute `terraform apply` to deploy the application and update the cloud function code.

### How it works

Every non-sensitive and non-terraform file is zipped into an archive and deployed to a Google Cloud Storage (GCS) using the [cloud-function.tf - data "archive_file" "dist"](./cloud-function.tf) reference.

Once the file is uploaded, the google cloud function is updated with the new zip file.

**Note :warning:**: Terraform `main.tf` must be at same level as `src`, `package.json`, `dist`, etc... Having a directory terraform file in a subdirectory will result in terraform not being able to find the code to upload. Technically, every files must be under `path.module` for terraform cloud to be able to handle code source.

## References

- https://github.com/GoogleCloudPlatform/functions-framework-nodejs/tree/main
- https://github.com/GoogleCloudPlatform/functions-framework-nodejs/blob/main/docs/typescript.md
