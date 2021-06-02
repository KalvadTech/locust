terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}

provider "scaleway" {
  zone            = "fr-par-1"
  region          = "fr-par"
}

data "scaleway_instance_image" "locust" {
  image_id = "ff48b73a-097d-4685-b996-d3ebe50636ea"
}

module "master" {
  source = "./modules/master"
  startup_script = templatefile(
    "./startup-master.sh",
    {
      "TASKS_URL" = var.tasks_url
      "LOCUST_TYPE" = "master"
      "LOCUST_USERNAME"               = var.locust_username
      "LOCUST_PASSWORD"               = var.locust_password
    }
    )
  image_id = data.scaleway_instance_image.locust.id
}

module "worker" {
  source = "./modules/worker"
  startup_script = templatefile(
    "./startup-worker.sh",
    {
      "TASKS_URL" = var.tasks_url
      "LOCUST_TYPE" = "worker"
      "LOCUST_MASTER_IP" = module.master.locust_master_ip
    }
    )
  image_id = data.scaleway_instance_image.locust.id
  workers_number = var.workers_nb
  depends_on = [
    module.master
  ]
}
