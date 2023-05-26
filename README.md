## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_scaleway"></a> [scaleway](#provider\_scaleway) | 2.1.0 |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_master"></a> [master](#module\_master) | ./modules/master | n/a |
| <a name="module_worker"></a> [worker](#module\_worker) | ./modules/worker | n/a |

## Resources

| Name | Type |
|------|------|
| [scaleway_instance_image.locust](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/instance_image) | data source |
| [template_file.startup-master](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.startup-worker](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"GP1-S"` | no |
| <a name="input_locust_file"></a> [locust\_file](#input\_locust\_file) | Locust File | `string` | n/a | yes |
| <a name="input_locust_password"></a> [locust\_password](#input\_locust\_password) | Locust Password | `string` | n/a | yes |
| <a name="input_locust_username"></a> [locust\_username](#input\_locust\_username) | Locust Username | `string` | n/a | yes |
| <a name="input_master_instance_type"></a> [master\_instance\_type](#input\_master\_instance\_type) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(string)` | `[]` | no |
| <a name="input_worker_instance_type"></a> [worker\_instance\_type](#input\_worker\_instance\_type) | n/a | `string` | `null` | no |
| <a name="input_workers_nb"></a> [workers\_nb](#input\_workers\_nb) | n/a | `number` | `5` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_locust_master_ip"></a> [locust\_master\_ip](#output\_locust\_master\_ip) | Master IP of locust |
| <a name="output_locust_worker_ips"></a> [locust\_worker\_ips](#output\_locust\_worker\_ips) | Worker IPs of locust |
