resource "google_secret_manager_secret" "secret" {
  secret_id = "secret"

  labels = {
    "managed-by" = "terraform"
  }

  replication {
    auto {}
  }

  depends_on = [google_project_service.gcp_services]
}

resource "google_secret_manager_secret_iam_member" "secret_access" {
  secret_id = google_secret_manager_secret.secret.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.account.email}"
}

resource "google_secret_manager_secret_version" "secret" {
  secret = google_secret_manager_secret.secret.name

  secret_data = "This is a secret from secret manager"
  enabled     = true
}
