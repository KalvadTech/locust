output "locust_master_ip" {
  description = "Master IP of locust"
  value = scaleway_instance_ip.master.address
}
