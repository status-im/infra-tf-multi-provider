/* DNS ------------------------------------------*/

variable "cf_zone_id" {
  description = "ID of CloudFlare zone for host record."
  type        = string
  /* We default to: statusim.net */
  default     = "14660d10344c9898521c4ba49789f563"
}

/* General --------------------------------------*/

variable "host_count" {
  description = "Number of hosts to run."
  type        = number
}

variable "name" {
  description = "Prefix of hostname before index."
  type        = string
  default     = "node"
}

variable "env" {
  description = "Environment for these hosts, affects DNS entries."
  type        = string
}

variable "stage" {
  description = "Name of stage, like prod, dev, or staging."
  type        = string
  default     = ""
}

variable "group" {
  description = "Ansible group to assign hosts to."
  type        = string
}

variable "domain" {
  description = "DNS Domain to update"
  type        = string
  default     = "statusim.net"
}

/* Scaling --------------------------------------*/

variable "do_size" {
  description = "Size of host to provision in Digital Ocean."
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "do_data_vol_size" {
  description = "Size in GiB of extra volume for host."
  type        = number
  default     = 0
}

variable "gc_size" {
  description = "Size of host to provision in Google Cloud."
  type        = string
  default     = "n1-standard-1"
}

variable "gc_root_vol_size" {
  description = "Size in GiB of the host volume."
  type        = number
  default     = 15
}

variable "gc_data_vol_size" {
  description = "Size in GiB of extra data volume for instance."
  type        = number
  default     = 0
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
