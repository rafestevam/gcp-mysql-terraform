variable "project_name" {
  description = "GCP Project name"
  type        = string
}

variable "region" {
  description = "Google Cloud region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Google Cloud zone"
  type        = string
  default     = "us-central1-a"
}

variable db_tier {
  description = "The machine tier (First Generation) or type (Second Generation). Reference: https://cloud.google.com/sql/pricing"
  default     = "db-f1-micro"
}