output "locust_worker_ips" {
  description = "Worker IPs of locust"
  value = [
    for worker in scaleway_instance_server.locust-worker :
    worker.public_ip
  ]
}
