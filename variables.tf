/* DNS ------------------------------------------*/

variable "cf_zone_id" {
  description = "ID of CloudFlare zone for host record."
  /* We default to: statusim.net */
  default     = "14660d10344c9898521c4ba49789f563"
}

/* General --------------------------------------*/

variable "host_count" {
  description = "Number of hosts to run."
}

variable "name" {
  description = "Prefix of hostname before index."
  default     = "node"
}

variable "env" {
  description = "Environment for these hosts, affects DNS entries."
}

variable "group" {
  description = "Ansible group to assign hosts to."
}

variable "domain" {
  description = "DNS Domain to update"
  default     = "statusim.net"
}

/* Scaling --------------------------------------*/

variable "do_size" {
  description = "Size of host to provision in Digital Ocean."
  default     = "s-1vcpu-1gb"
}

variable "do_data_vol_size" {
  description = "Size in GiB of extra volume for host."
  default     = 0
}

variable "gc_size" {
  description = "Size of host to provision in Google Cloud."
  default     = "n1-standard-1"
}

variable "gc_root_vol_size" {
  description = "Size in GiB of the host volume."
  default     = 15
}

variable "gc_data_vol_size" {
  description = "Size in GiB of extra data volume for instance."
  default     = 0
}

variable "ac_size" {
  description = "Size of host to provision in Alibaba Cloud."
  default     = "ecs.t5-lc1m1.small"
}

variable "ac_data_vol_size" {
  description = "Size of extra data volume attached to the instance."
  default     = 0
}

/* Firewall--------------------------------------*/

variable "open_tcp_ports" {
  description = "TCP port ranges to enable access from outside. Format: 'N-N'"
  type        = list(string)
  default     = ["80-80", "443-443"]
}

variable "open_udp_ports" {
  description = "UDP port ranges to enable access from outside. Format: 'N-N'"
  type        = list(string)
  default     = []
}
