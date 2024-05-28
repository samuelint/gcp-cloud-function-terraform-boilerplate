locals {
  function_name = "functions-framework-playground-${var.environment}"
}

resource "google_service_account" "account" {
  account_id   = "gcf-playground-${var.environment}-sa"
  display_name = local.function_name
}

resource "google_project_iam_member" "function_roles" {
  for_each = toset([
    "roles/logging.logWriter",
    "roles/run.invoker",
    "roles/storage.objectViewer",
    "roles/artifactregistry.reader",
    "roles/artifactregistry.writer"
  ])
  project = var.gcp_project
  role    = each.key
  member  = format("serviceAccount:%s", google_service_account.account.email)

  depends_on = [google_project_service.gcp_services]
}

resource "google_storage_bucket_iam_member" "bucket_reader" {
  bucket = google_storage_bucket.default.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.account.email}"
}

data "archive_file" "dist" {
  type                        = "zip"
  source_dir                  = path.module
  exclude_symlink_directories = true
  excludes                    = ["*.tf", "*.tfvars", ".gitignore", ".git", ".terraform", ".DS_Store", ".vscode", ".env"]
  output_file_mode            = "0666"
  output_path                 = "${path.module}/${timestamp()}-dist.zip"
}

resource "google_storage_bucket_object" "object" {
  name   = "function-source-${timestamp()}.zip"
  bucket = google_storage_bucket.default.name
  source = data.archive_file.dist.output_path
}

resource "google_cloudfunctions2_function" "default" {
  name     = "functions-framework-playground-${var.environment}"
  location = var.gcp_location

  build_config {
    runtime     = "nodejs20"
    entry_point = "main"
    source {
      storage_source {
        bucket = google_storage_bucket.default.name
        object = google_storage_bucket_object.object.name
      }
    }
    service_account = google_service_account.account.id
  }

  service_config {
    max_instance_count    = 1
    available_memory      = "256M"
    timeout_seconds       = 60
    service_account_email = google_service_account.account.email
  }

  depends_on = [google_project_iam_member.function_roles]
}

output "function_uri" {
  value = google_cloudfunctions2_function.default.service_config[0].uri
}
