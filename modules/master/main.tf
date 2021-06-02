terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}

resource "scaleway_instance_ip" "master" {
}

resource "scaleway_instance_server" "master" {
  name       = "locust-master"
  ip_id      = scaleway_instance_ip.master.id
  image      = var.image_id
  type       = "DEV1-L"
  cloud_init = var.startup_script
}
