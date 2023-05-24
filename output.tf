
output "locust_master_ip" {
  description = "Master IP of locust"
  value       = module.master.locust_master_ip
}

output "locust_worker_ips" {
  description = "Worker IPs of locust"
  value       = module.worker.locust_worker_ips
}
