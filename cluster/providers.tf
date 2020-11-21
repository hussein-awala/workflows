provider "google" {
  credentials = file(var.gcp_credentials)
  project     = var.project_id
  region      = var.region
}

provider "google-beta" {
  credentials = file(var.gcp_credentials)
  project     = var.project_id
  region      = var.region
}

