/* Digital Ocean */

variable "do_count" {
  description = "Number of Digital Ocean hosts to run."
  type        = number
  default     = -1
}

variable "do_type" {
  description = "Type of host to provision in Digital Ocean."
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "do_data_vol_size" {
  description = "Size in GiB of extra volume for host."
  type        = number
  default     = 0
}


module "do-eu-amsterdam3" {
  source = "github.com/status-im/infra-tf-digital-ocean"

  /* specific */
  name  = var.name
  group = var.group
  env   = var.env
  stage = local.stage

  /* scaling */
  count      = local.do_count > 0 ? 1 : 0
  host_count = local.do_count
  type       = var.do_type
  region     = "ams3"

  /* disks */
  data_vol_size = var.do_data_vol_size

  /* general */
  domain     = var.domain
  cf_zone_id = var.cf_zone_id

  /* firewall */
  open_tcp_ports = var.open_tcp_ports
  open_udp_ports = var.open_udp_ports
}

resource "cloudflare_record" "do-eu-amsterdam3" {
  zone_id = var.cf_zone_id
  name    = "nodes.do-ams3.${local.fleet}"
  value   = one(module.do-eu-amsterdam3[*].public_ips)[count.index]
  count   = local.do_count
  type    = "A"
}
