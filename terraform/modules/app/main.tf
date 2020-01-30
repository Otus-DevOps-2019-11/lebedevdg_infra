resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "f1-micro"
  zone         = var.zone
  tags         = ["reddit-app"]
  boot_disk {
    initialize_params {
      image = var.app_disk_image
    }
  }


  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.app_ip.address
    }
  }

  connection {
    type  = "ssh"
    host  = self.network_interface[0].access_config[0].nat_ip
    user  = "appuser"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key)
  }


  provisioner "file" {
    content     = templatefile("${path.module}/deploy.tmpl", { database_url = var.database_ip })
    destination = var.enable_provision ? "/tmp/deploy.sh" : "/dev/null"
  }


  provisioner "remote-exec" {
    inline = [var.enable_provision ? "chmod 777 /tmp/deploy.sh && /tmp/deploy.sh" : "exit 0"]
  }


}
resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}


resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}
