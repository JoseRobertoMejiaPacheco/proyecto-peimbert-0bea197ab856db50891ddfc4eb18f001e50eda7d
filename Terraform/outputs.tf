output "instance_ip" {
  value = google_compute_instance.stpsinstance.network_interface.0.network_ip
}

output "public_ip" {
  value = google_compute_address.static.address
}
