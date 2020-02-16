terraform {
  required_version = "~> 0.12.0"
}
provider "google" {
  version = "2.15"
  # ID проекта
  project = var.project
  region  = var.region
}


module "app" {
  source           = "../modules/app"
  zone             = var.zone
  app_disk_image   = var.app_disk_image
  database_ip      = module.db.db_internal_ip
  enable_provision = false
}

module "db" {
  source           = "../modules/db"
  zone             = var.zone
  db_disk_image    = var.db_disk_image
  enable_provision = false
}


module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["0.0.0.0/0"]

}


resource "google_compute_project_metadata_item" "default" {
  key     = "ssh-keys"
  value   = "appuser:${file(var.public_key_path)}\nappuser1:${file(var.public_key_path)}\nappuser2:${file(var.public_key_path)}"
  project = var.project
}
