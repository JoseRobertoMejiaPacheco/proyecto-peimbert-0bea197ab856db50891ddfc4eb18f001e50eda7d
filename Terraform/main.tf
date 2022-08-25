provider "google" {
  project = var.project
  region  = var.region
}

resource "google_compute_firewall" "firewall" {
  name    = "stps-firewall-externalssh"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"] # Not So Secure. Limit the Source Range
  target_tags   = ["externalssh"]
}

resource "google_compute_firewall" "webserverrule" {
  name    = "stps-webserver"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["80","443"]
  }
  source_ranges = ["0.0.0.0/0"] # Not So Secure. Limit the Source Range
  target_tags   = ["webserver"]
}

# We create a public IP address for our google compute instance to utilize
resource "google_compute_address" "static" {
  name = "vm-public-address"
  project = var.project
  region = var.region
  depends_on = [ google_compute_firewall.firewall ]
}

resource "google_compute_instance" "stpsinstance" {
  name         = "stps-instance"
  machine_type = "e2-medium"
  zone         = "${var.region}-a"
  tags         = ["externalssh","webserver"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  connection {
     host        = google_compute_address.static.address
     type        = "ssh"
     user        = var.user 
     timeout     = "500s"
     private_key = file(var.privatekeypath)
   }

  provisioner "file" {
   source      = "data/init.sh"
   destination = "/tmp/init.sh"
 }

  provisioner "remote-exec" {
   inline = [
     "chmod +x /tmp/init.sh",
     "/tmp/init.sh",
   ]
 }

  # Ensure firewall rule is provisioned before server, so that SSH doesn't fail.
  depends_on = [ google_compute_firewall.firewall, google_compute_firewall.webserverrule ]

  service_account {
    email  = var.email
    scopes = ["compute-ro"]
  }

  metadata = {
    ssh-keys = "${var.user}:${file(var.publickeypath)}"
  }

}
