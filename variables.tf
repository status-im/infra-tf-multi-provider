variable count {
  description = "Number of hosts to run."
}

variable name {
  description = "Prefix of hostname before index."
  default     = "node"
}

variable env {
  description = "Environment for these hosts, affects DNS entries."
}

variable group {
  description = "Ansible group to assign hosts to."
}

variable domain {
  description = "DNS Domain to update"
  default     = "statusim.net"
}

# Scaling

variable do_size {
  description = "Size of host to provision in Digital Ocean."
  default     = "s-1vcpu-1gb"
}

variable gc_size {
  description = "Size of host to provision in Google Cloud."
  default     = "n1-standard-1"
}

variable ac_size {
  description = "Size of host to provision in Alibaba Cloud."
  default     = "ecs.t5-lc1m1.small"
}

# Firewall

variable open_ports {
  description = "TCP ports to enable access from outside."
  type        = "list"
  default     = [ "80-80", "443-443" ]
}
