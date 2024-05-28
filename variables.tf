variable "gcp_project" {
  description = "GCP Project"
  type        = string
  default     = "pivotal-bonbon-424619-g6" // Sandbox
}

variable "gcp_location" {
  description = "GCP Location"
  type        = string
  default     = "northamerica-northeast1" // Montreal
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "sandbox"
}
