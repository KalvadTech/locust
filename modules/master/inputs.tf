variable "startup_script" {
  type = string
}

variable "image_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "organization_id" {
  type      = string
  sensitive = true
}
variable "project_id" {
  type      = string
  sensitive = true
}