variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "europe-north1-a"
}
variable app_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-base-app"
}
variable "database_ip" {
  description = "Reddit app database url"
  default     = "127.0.0.1:27017"
}
variable private_key {
  description = "SSH pisk key"
  default     = "/root/.ssh/appuser"
}
variable "enable_provision" {
  default = true
}
