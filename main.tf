/**
 * The number of hosts created for each supported Providers is controlled
 * by either the count for the given provider(e.g., `do_count`) or the default
 * set via `host_count` variable.
 * If count is set to `0` the whole module is disabled, this includes all
 * the support resources like firewall rules or security groups.
 *
 * Each provider configuration exists in a `module_*.tf` file.
 */

locals {
  stage = var.stage != "" ? var.stage : terraform.workspace
  fleet = "${var.env}.${local.stage}"
  /* Counts, default to general count. */
  ac_count = var.ac_count != -1 ? var.ac_count : var.host_count
  do_count = var.do_count != -1 ? var.do_count : var.host_count
  gc_count = var.gc_count != -1 ? var.gc_count : var.host_count
}

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

/* Google Cloud */

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
  type       = var.gc_size
  zone       = "us-central1-a"

  /* disks */
  root_vol_size = var.gc_root_vol_size
  data_vol_size = var.gc_data_vol_size

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

/* Alibaba Cloud */

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
