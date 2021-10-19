/* Alibaba Cloud */

variable "ac_count" {
  description = "Number of Alibaba Cloud hosts to run."
  type        = number
  default     = -1
}

variable "ac_size" {
  description = "Size of host to provision in Alibaba Cloud."
  type        = string
  default     = "ecs.t5-lc1m1.small"
}

variable "ac_data_vol_size" {
  description = "Size of extra data volume attached to the instance."
  type        = number
  default     = 0
}

module "ac-cn-hongkong-c" {
  source = "github.com/status-im/infra-tf-alibaba-cloud"

  /* specific */
  name  = var.name
  group = var.group
  env   = var.env
  stage = local.stage

  /* scaling */
  count      = local.ac_count > 0 ? 1 : 0
  host_count = local.ac_count
  type       = var.ac_size
  zone       = "cn-hongkong-c"

  /* disks */
  data_vol_size = var.ac_data_vol_size

  /* general */
  domain     = var.domain
  cf_zone_id = var.cf_zone_id

  /* firewall */
  open_tcp_ports = var.open_tcp_ports
  open_udp_ports = var.open_udp_ports
}

resource "cloudflare_record" "ac-cn-hongkong-c" {
  zone_id = var.cf_zone_id
  name    = "nodes.ac-cn-hongkong-c.${local.fleet}"
  value   = one(module.ac-cn-hongkong-c[*].public_ips)[count.index]
  count   = local.ac_count
  type    = "A"
}
