terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}

provider "scaleway" {
  organization_id = var.organization_id
  project_id      = var.project_id
}

data "scaleway_instance_image" "locust" {
  image_id = "81b9475d-e1b5-43c2-ac48-4c1a3b640686"
}


locals {
  locust_tags = join(" ", [for item in var.tags : "-T ${item}"])
}

# startup-master.yaml data source
data "template_file" "startup-master" {
  template = file("${path.module}/startup-master.yaml")
  vars = {
    LOCUST_FILE     = filebase64(var.locust_file)
    LOCUST_TYPE     = "master"
    LOCUST_USERNAME = var.locust_username
    LOCUST_PASSWORD = var.locust_password
    LOCUST_TAGS     = local.locust_tags
  }
}


# startup-worker.yaml data source
data "template_file" "startup-worker" {
  template = file("${path.module}/startup-worker.yaml")
  vars = {
    LOCUST_FILE      = filebase64(var.locust_file)
    LOCUST_TYPE      = "worker"
    LOCUST_MASTER_IP = module.master.locust_master_ip
    LOCUST_TAGS      = local.locust_tags
  }
}

module "master" {
  organization_id = var.organization_id
  project_id      = var.project_id
  source          = "./modules/master"
  startup_script  = data.template_file.startup-master.rendered
  image_id        = data.scaleway_instance_image.locust.id
  instance_type   = var.master_instance_type != null ? var.master_instance_type : var.instance_type
}

module "worker" {
  organization_id = var.organization_id
  project_id      = var.project_id
  source          = "./modules/worker"
  startup_script  = data.template_file.startup-worker.rendered
  image_id        = data.scaleway_instance_image.locust.id
  instance_type   = var.worker_instance_type != null ? var.worker_instance_type : var.instance_type
  workers_number  = var.workers_nb
  depends_on = [
    module.master
  ]
}
