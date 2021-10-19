/* Digital Ocean */

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
  size       = var.do_size
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
