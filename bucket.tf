resource "google_storage_bucket" "default" {
  name                        = "smagny-com--${var.environment}--functions-framework-playground" # Every bucket name must be globally unique
  location                    = var.gcp_location
  uniform_bucket_level_access = true
  labels = {
    "managed-by" = "terraform"
  }
}
