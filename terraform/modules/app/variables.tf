variable public_key_path {
  description = "Path to the public key used to connect to instance"
}

variable private_key_path {
  description = "Path to the private key used for provisioners to connect to instance"
}

variable zone {
  description = "Zone"
}

variable app_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}

variable mongo_ip {
  description = "Mongod ip:port"
}
