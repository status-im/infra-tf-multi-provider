/* DNS ------------------------------------------*/

variable "cf_zone_id" {
  description = "ID of CloudFlare zone for host record."
  type        = string
  default     = "fd48f427e99bbe1b52105351260690d1"
}

variable "domain" {
  description = "DNS Domain to update"
  type        = string
  default     = "status.im"
}

/* General --------------------------------------*/

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

/* Scaling --------------------------------------*/

/* Provider specific variables are in dedicated files. */
variable "host_count" {
  description = "Number of hosts to run. Overridden by individual provider counts."
  type        = number
  default     = 1
}

/* Firewall--------------------------------------*/

variable "open_tcp_ports" {
  description = "TCP port ranges to enable access from outside. Format: 'N', 'N-N'"
  type        = list(string)
  default     = []
}

variable "open_udp_ports" {
  description = "UDP port ranges to enable access from outside. Format: 'N', 'N-N'"
  type        = list(string)
  default     = []
}
