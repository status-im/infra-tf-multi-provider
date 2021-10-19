output "public_ips" {
  value = flatten([
    one(module.do-eu-amsterdam3[*].public_ips),
    one(module.gc-us-central1-a[*].public_ips),
    one(module.ac-cn-hongkong-c[*].public_ips),
  ])
}

output "hosts" {
  value = merge(
    one(module.do-eu-amsterdam3[*].hosts),
    one(module.gc-us-central1-a[*].hosts),
    one(module.ac-cn-hongkong-c[*].hosts),
  )
}

output "hosts_by_dc" {
  value = {
    "do-eu-amsterdam3" = one(module.do-eu-amsterdam3[*].hosts)
    "gc-us-central1-a" = one(module.gc-us-central1-a[*].hosts)
    "ac-cn-hongkong-c" = one(module.ac-cn-hongkong-c[*].hosts)
  }
}
