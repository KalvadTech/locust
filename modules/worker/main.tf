terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}

resource "scaleway_instance_ip" "ip_workers" {
  count = var.workers_number
}

resource "scaleway_instance_server" "locust-worker" {
  count      = var.workers_number
  name       = "locust-worker-${count.index}"
  ip_id      = scaleway_instance_ip.ip_workers[count.index].id
  image      = var.image_id
  type       = "GP1-L"
  cloud_init = var.startup_script
}
