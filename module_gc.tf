/* Google Cloud */

variable "gc_count" {
  description = "Number of Google Cloud hosts to run."
  type        = number
  default     = -1
}

variable "gc_type" {
  description = "Type of host to provision in Google Cloud."
  type        = string
  default     = "n1-standard-1"
}

variable "gc_root_vol_size" {
  description = "Size in GiB of the host volume."
  type        = number
  default     = 15
}

variable "gc_root_vol_type" {
  description = "Size of the base image."
  type        = string
  default     = "pd-standard"
}

variable "gc_data_vol_size" {
  description = "Size in GiB of extra data volume for instance."
  type        = number
  default     = 0
}

variable "gc_data_vol_type" {
  description = "Type of the extra data volume."
  type        = string
  default     = "pd-balanced"
  /* Use: gcloud compute disk-types list */
}

module "gc-us-central1-a" {
  source = "github.com/status-im/infra-tf-google-cloud"

  /* specific */
  name  = var.name
  group = var.group
  env   = var.env
  stage = local.stage

  /* scaling */
  count      = local.gc_count > 0 ? 1 : 0
  host_count = local.gc_count
  type       = var.gc_type
  zone       = "us-central1-a"

  /* disks */
  root_vol_size = var.gc_root_vol_size
  root_vol_type = var.gc_root_vol_type
  data_vol_size = var.gc_data_vol_size
  data_vol_type = var.gc_data_vol_type

  /* general */
  domain     = var.domain
  cf_zone_id = var.cf_zone_id

  /* firewall */
  open_tcp_ports = var.open_tcp_ports
  open_udp_ports = var.open_udp_ports
}

resource "cloudflare_record" "gc-us-central1-a" {
  zone_id = var.cf_zone_id
  name    = "nodes.gc-us-central1-a.${local.fleet}"
  value   = one(module.gc-us-central1-a[*].public_ips)[count.index]
  count   = local.gc_count
  type    = "A"
}
