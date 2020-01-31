resource "google_compute_instance" "db" {
  name         = "reddit-db"
  machine_type = "f1-micro"
  zone         = var.zone
  tags         = ["reddit-db"]
  boot_disk {
    initialize_params {
      image = var.db_disk_image
    }
  }

  # Определяем переменную с ip
  network_interface {
    network = "default"
    access_config {}
  }



  connection {
    type  = "ssh"
    host  = self.network_interface[0].access_config[0].nat_ip
    user  = "appuser"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key)
  }


  provisioner "remote-exec" {
    inline = [var.enable_provision ? "sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf && sudo systemctl restart mongod || echo Error" : "exit 0"]
  }
}




# Правило firewall
resource "google_compute_firewall" "firewall_mongo" {
  name    = "allow-mongo-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }
  target_tags = ["reddit-db"]
  source_tags = ["reddit-app"]
}
