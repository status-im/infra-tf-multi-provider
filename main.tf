/**
 * Unfortunately Terraform does not support using the count parameter
 * with custom modules, for more details see:
 * https://github.com/hashicorp/terraform/issues/953
 *
 * Because of this to add a region/zone you have to copy a provider
 * module and give it a different region/size argument.
 */

/* Digital Ocean */

module "do-eu-amsterdam3" {
  source = "github.com/status-im/infra-tf-digital-ocean"

  /* specific */
  name  = var.name
  env   = var.env
  group = var.group

  /* scaling */
  host_count = var.host_count
  size       = var.do_size
  vol_size   = var.do_vol_size
  region     = "ams3"

  /* general */
  domain     = var.domain
  cf_zone_id = var.cf_zone_id

  /* firewall */
  open_tcp_ports = var.open_tcp_ports
  open_udp_ports = var.open_udp_ports
}

resource "cloudflare_record" "do-eu-amsterdam3" {
  zone_id = var.cf_zone_id
  name    = "nodes.do-ams3.${var.env}.${terraform.workspace}"
  value   = module.do-eu-amsterdam3.public_ips[count.index]
  count   = length(module.do-eu-amsterdam3.public_ips)
  type    = "A"
}

/* Google Cloud */

module "gc-us-central1-a" {
  source = "github.com/status-im/infra-tf-google-cloud"

  /* specific */
  name  = var.name
  env   = var.env
  group = var.group

  /* scaling */
  host_count = var.host_count
  type       = var.gc_size
  vol_size   = var.gc_vol_size
  zone       = "us-central1-a"

  /* general */
  domain     = var.domain
  cf_zone_id = var.cf_zone_id

  /* firewall */
  open_tcp_ports = var.open_tcp_ports
  open_udp_ports = var.open_udp_ports
}

resource "cloudflare_record" "gc-us-central1-a" {
  zone_id = var.cf_zone_id
  name    = "nodes.gc-us-central1-a.${var.env}.${terraform.workspace}"
  value   = module.gc-us-central1-a.public_ips[count.index]
  count   = length(module.gc-us-central1-a.public_ips)
  type    = "A"
}

/* Alibaba Cloud */

module "ac-cn-hongkong-c" {
  source = "github.com/status-im/infra-tf-alibaba-cloud"

  /* specific */
  name  = var.name
  env   = var.env
  group = var.group

  /* scaling */
  host_count = var.host_count
  type       = var.ac_size
  zone       = "cn-hongkong-c"

  /* general */
  domain     = var.domain
  cf_zone_id = var.cf_zone_id

  /* firewall */
  open_tcp_ports = var.open_tcp_ports
  open_udp_ports = var.open_udp_ports
}

resource "cloudflare_record" "ac-cn-hongkong-c" {
  zone_id = var.cf_zone_id
  name    = "nodes.ac-cn-hongkong-c.${var.env}.${terraform.workspace}"
  value   = module.ac-cn-hongkong-c.public_ips[count.index]
  count   = length(module.ac-cn-hongkong-c.public_ips)
  type    = "A"
}
