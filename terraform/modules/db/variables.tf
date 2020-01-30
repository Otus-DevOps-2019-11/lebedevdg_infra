variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "europe-north1-a"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-base-db"
}
variable private_key {
  description = "SSH pisk key"
  default     = "/root/.ssh/appuser"
}
variable "enable_provision" {
  default = true
}
