variable project {
  description = "devops-course-1"
}
variable region {
  description = "Region"
  # Значение по умолчанию
  default = "europe-west1"
}
variable public_key_path {
  # Описание переменной
  description = "~/.ssh/appuser.pub"
}
variable disk_image {
  description = "reddit-base-1569325898"
}
variable private_key_path {
  description = "~/.ssh/appuser"
}
variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}
variable count_instances {
  description = "Number of app instances"
  default     = 1
}
