/* Amazon Web Services */

variable "aws_count" {
  description = "Number of AWS hosts to run."
  type        = number
  default     = -1
}

variable "aws_type" {
  description = "Type of host to provision in AWS."
  type        = string
  default     = "n1-standard-1"
}

variable "aws_root_vol_size" {
  description = "Size in GiB of the host root volume."
  type        = number
  default     = 15
}

variable "aws_data_vol_size" {
  description = "Size in GiB of extra data volume for instance."
  type        = number
  default     = 0
}

variable "aws_keypair_name" {
  description = "Name of SSH key pair in AWS."
  type        = string
  default     = ""
}

variable "aws_vpc_id" {
  description = "ID of the VPC for instances"
  type        = string
  default     = ""
}

variable "aws_subnet_id" {
  description = "ID of the Subnet for instances"
  type        = string
  default     = ""
}

variable "aws_secgroup_id" {
  description = "ID of the Security Group for instances"
  type        = string
  default     = ""
}

module "aws-eu-central-1a" {
  source = "github.com/status-im/infra-tf-amazon-web-services"

  /* specific */
  name  = var.name
  group = var.group
  env   = var.env
  stage = local.stage

  /* scaling */
  count      = local.aws_count > 0 ? 1 : 0
  host_count = local.aws_count
  type       = var.aws_type
  zone       = "eu-central-1a"

  /* disks */
  root_vol_size = var.aws_root_vol_size
  data_vol_size = var.aws_data_vol_size

  /* general */
  domain     = var.domain
  cf_zone_id = var.cf_zone_id

  /* plumbing */
  keypair_name = var.aws_keypair_name
  vpc_id       = var.aws_vpc_id
  subnet_id    = var.aws_subnet_id
  secgroup_id  = var.aws_secgroup_id

  /* firewall */
  open_tcp_ports = var.open_tcp_ports
  open_udp_ports = var.open_udp_ports
}

resource "cloudflare_record" "aws-eu-central-1a" {
  zone_id = var.cf_zone_id
  name    = "nodes.do-ams3.${local.fleet}"
  value   = one(module.aws-eu-central-1a[*].public_ips)[count.index]
  count   = local.aws_count
  type    = "A"
}
