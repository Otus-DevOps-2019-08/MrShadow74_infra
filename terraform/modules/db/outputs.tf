output "db_external_ip" {
  value = google_compute_instance.db.network_interface[0].access_config[0].nat_ip
  #value = module.db.app_external_ip
}

##output "lb_externa_ip" {
#  value = google_compute_forwarding_rule.default.ip_address
#}
