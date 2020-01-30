variable project {
  description = "Project ID"
}
variable region {
  description = "Region"
  # Значение по умолчанию
  default = "europe-north1"
}
variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "europe-north1-a"
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable private_key {
  description = "SSH pisk key"
}
variable app_disk_image {
  description = "app images"
  default     = "reddit-base-app"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-base-db"
}
