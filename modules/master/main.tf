terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}
variable "organization_id" {
  type      = string
  sensitive = true
}
variable "project_id" {
  type      = string
  sensitive = true
}

resource "scaleway_instance_ip" "master" {
  project_id = var.project_id
}

resource "scaleway_instance_server" "master" {
  project_id = var.project_id
  name       = "locust-master"
  ip_id      = scaleway_instance_ip.master.id
  image      = var.image_id
  type       = var.instance_type
  cloud_init = var.startup_script
}
