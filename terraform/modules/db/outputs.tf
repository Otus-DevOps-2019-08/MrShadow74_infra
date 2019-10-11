output "db_local_ip" {
  value = google_compute_instance.db.network_interface.0.network_ip
}

output "mongo_ip" {
  value = google_compute_instance.db.network_interface[0].network_ip
}

output "mongo_port" {
  value = "27017"
}
