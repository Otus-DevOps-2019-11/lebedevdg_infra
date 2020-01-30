terraform {
  backend "gcs" {
    bucket = "storage-bucket-infra-265717"
    prefix = "stage"
  }
}
