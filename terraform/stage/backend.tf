terraform {
  required_version = "~> 0.12"
  backend "gcs" {
    bucket = "storage-bucket-mrstest"
    prefix = "terraform/state/stage"
  }
}

