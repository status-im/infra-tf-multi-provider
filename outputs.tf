output "public_ips" {
  value = flatten([
    module.do-eu-amsterdam3.public_ips,
    module.gc-us-central1-a.public_ips,
    module.ac-cn-hongkong-c.public_ips,
  ])
}

output "hosts" {
  value = merge(
    module.do-eu-amsterdam3.hosts,
    module.gc-us-central1-a.hosts,
    module.ac-cn-hongkong-c.hosts,
  )
}

output "hosts_by_dc" {
  value = {
    "do-eu-amsterdam3" = module.do-eu-amsterdam3.hosts
    "gc-us-central1-a" = module.gc-us-central1-a.hosts
    "ac-cn-hongkong-c" = module.ac-cn-hongkong-c.hosts
  }
}
