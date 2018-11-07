/**
 * Unfortunately Terraform does not support using the count parameter
 * with custom modules, for more details see:
 * https://github.com/hashicorp/terraform/issues/953
 *
 * Because of this to add a region/zone you have to copy a provider
 * module and give it a different region/size argument.
 */

/* Digital Ocean */

module "do-ams3" {
  source    = "github.com/status-im/infra-tf-digital-ocean"
  /* specific */
  count     = "${var.count}"
  name      = "${var.name}"
  env       = "${var.env}"
  group     = "${var.group}"
  /* scaling */
  size      = "${var.do_size}"
  vol_size  = "${var.do_vol_size}"
  region    = "ams3"
  /* general */
  domain     = "${var.domain}"
  /* firewall */
  open_ports = "${var.open_ports}"
}

resource "cloudflare_record" "do-ams3" {
  domain = "${var.domain}"
  name   = "nodes.do-ams3.${var.env}.${terraform.workspace}"
  value  = "${element(module.do-ams3.public_ips, count.index)}"
  count  = "${var.count}"
  type   = "A"
}

/* Google Cloud */

module "gc-us-central1-a" {
  source     = "github.com/status-im/infra-tf-google-cloud"
  /* specific */
  count      = "${var.count}"
  name       = "${var.name}"
  env        = "${var.env}"
  group      = "${var.group}"
  /* scaling */
  type       = "${var.gc_size}"
  zone       = "us-central1-a"
  /* general */
  domain     = "${var.domain}"
  /* firewall */
  open_ports = "${var.open_ports}"
}

resource "cloudflare_record" "gc-us-central1-a" {
  domain = "${var.domain}"
  name   = "nodes.gc-us-central1-a.${var.env}.${terraform.workspace}"
  value  = "${element(module.gc-us-central1-a.public_ips, count.index)}"
  count  = "${var.count}"
  type   = "A"
}

/* Alibaba Cloud */

module "ac-cn-hongkong-c" {
  source     = "github.com/status-im/infra-tf-alibaba-cloud"
  /* specific */
  count      = "${var.count}"
  name       = "${var.name}"
  env        = "${var.env}"
  group      = "${var.group}"
  /* scaling */
  type       = "${var.ac_size}"
  zone       = "cn-hongkong-c"
  /* general */
  domain     = "${var.domain}"
  /* firewall */
  open_ports = "${var.open_ports}"
}

resource "cloudflare_record" "ac-cn-hongkong-c" {
  domain = "${var.domain}"
  name   = "nodes.ac-cn-hongkong-c.${var.env}.${terraform.workspace}"
  value  = "${element(module.ac-cn-hongkong-c.public_ips, count.index)}"
  count  = "${var.count}"
  type   = "A"
}
