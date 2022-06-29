/* Hetzner Cloud */

variable "he_count" {
  description = "Number of Hetzner Cloud hosts to run."
  type        = number
  default     = -1
}

variable "he_type" {
  description = "Size of host to provision in Hetzner Cloud."
  type        = string
  default     = "cx11"
}

variable "he_data_vol_size" {
  description = "Size in GiB of extra volume for host."
  type        = number
  default     = 0
}


module "he-eu-helsinki1" {
  source = "github.com/status-im/infra-tf-hetzner-cloud"

  /* specific */
  name  = var.name
  group = var.group
  env   = var.env
  stage = local.stage

  /* scaling */
  count      = local.he_count > 0 ? 1 : 0
  host_count = local.he_count
  type       = var.he_type
  location   = "ams3"

  /* disks */
  data_vol_size = var.he_data_vol_size

  /* general */
  domain     = var.domain
  cf_zone_id = var.cf_zone_id

  /* firewall */
  open_tcp_ports = var.open_tcp_ports
  open_udp_ports = var.open_udp_ports
}

resource "cloudflare_record" "he-eu-helsinki1" {
  zone_id = var.cf_zone_id
  name    = "nodes.he-eu-hel1.${local.fleet}"
  value   = one(module.he-eu-helsinki1[*].public_ips)[count.index]
  count   = local.he_count
  type    = "A"
}
