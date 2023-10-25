variable "organization_id" {
  type = string
  sensitive = true
}

variable "project_id" {
  type = string
  sensitive = true
}
variable "locust_username" {
  type        = string
  description = "Locust Username"
}

variable "locust_password" {
  type        = string
  description = "Locust Password"
  sensitive   = true
}

variable "locust_file" {
  type        = string
  description = "Locust File"
}

variable "workers_nb" {
  type    = number
  default = 5
}

variable "tags" {
  type    = list(string)
  default = []
}

variable "master_instance_type" {
  type    = string
  default = null
}

variable "worker_instance_type" {
  type    = string
  default = null
}

variable "instance_type" {
  type    = string
  default = "GP1-S"
}
