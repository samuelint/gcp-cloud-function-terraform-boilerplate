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
    "roles/artifactregistry.writer",
    "roles/secretmanager.secretAccessor",
  ])
  project = var.gcp_project
  role    = each.key
  member  = format("serviceAccount:%s", google_service_account.account.email)

  depends_on = [google_project_service.gcp_services]
}
