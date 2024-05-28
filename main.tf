
terraform {
  cloud {
    organization = "smagny"

    workspaces {
      name = "gcp-functions-framework-playground"
    }
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.30.0"
    }
  }
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_location
}

resource "google_project_service" "gcp_services" {
  for_each = toset([
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "storage-api.googleapis.com",
  ])
  project = var.gcp_project
  service = each.key

  timeouts {
    create = "30m"
    update = "40m"
  }
}
