/* Alibaba Cloud */

variable "ac_count" {
  description = "Number of Alibaba Cloud hosts to run."
  type        = number
  default     = -1
}

variable "ac_type" {
  description = "Type of host to provision in Alibaba Cloud."
  type        = string
  default     = "ecs.t5-lc1m1.small"
}

variable "ac_root_vol_size" {
  description = "Size in GiB of the root volume."
  type        = number
  default     = 20
}

variable "ac_root_vol_type" {
  description = "I/O optimization type of root volume."
  type        = string
  default     = "cloud_ssd"
}

variable "ac_data_vol_size" {
  description = "Size in GiB of extra data volume for instance."
  type        = number
  default     = 0
}

variable "ac_data_vol_type" {
  description = "I/O optimization type of extra data volume."
  type        = string
  default     = "cloud_efficiency"
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
  type       = var.ac_type
  zone       = "cn-hongkong-c"

  /* disks */
  root_vol_size = var.ac_root_vol_size
  root_vol_type = var.ac_root_vol_type
  data_vol_size = var.ac_data_vol_size
  data_vol_type = var.ac_data_vol_type

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
