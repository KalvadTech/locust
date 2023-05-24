terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
}

data "scaleway_instance_image" "locust" {
  image_id = "ff48b73a-097d-4685-b996-d3ebe50636ea"
}



locals {
  locust_tags = join(" ", [for item in var.tags : "-T ${item}"])
}

# startup-master.yaml data source
data "template_file" "startup-master" {
  template = file("${path.module}/startup-master.yaml")
  vars = {
    TASKS_URL       = var.tasks_url
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
    TASKS_URL        = var.tasks_url
    LOCUST_TYPE      = "worker"
    LOCUST_MASTER_IP = module.master.locust_master_ip
    LOCUST_TAGS      = local.locust_tags
  }
}

module "master" {
  source         = "./modules/master"
  startup_script = data.template_file.startup-master.rendered
  image_id       = data.scaleway_instance_image.locust.id
}

module "worker" {
  source         = "./modules/worker"
  startup_script = data.template_file.startup-worker.rendered
  image_id       = data.scaleway_instance_image.locust.id
  workers_number = var.workers_nb
  depends_on = [
    module.master
  ]
}
