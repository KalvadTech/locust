variable "tasks_url" {
  type        = string
  description = "Where to download the tasks"
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

variable "workers_nb" {
  type    = number
  default = 5
}

variable "tags" {
  type    = list(string)
  default = []
}
