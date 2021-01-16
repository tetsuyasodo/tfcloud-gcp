provider "google" {
  project     = var.PROJECT_ID
  credentials = var.GOOGLE_CREDENTIALS
}

provider "random" {}
