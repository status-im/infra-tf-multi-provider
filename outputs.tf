output "public_ips" {
  value = flatten([
    one(module.ac-cn-hongkong-c[*].public_ips),
    one(module.aws-eu-central-1a[*].public_ips),
    one(module.do-eu-amsterdam3[*].public_ips),
    one(module.gc-us-central1-a[*].public_ips),
  ])
}

output "hosts" {
  value = merge(
    one(module.ac-cn-hongkong-c[*].hosts),
    one(module.aws-eu-central-1a[*].hosts),
    one(module.do-eu-amsterdam3[*].hosts),
    one(module.gc-us-central1-a[*].hosts),
  )
}

output "hosts_by_dc" {
  value = {
    "ac-cn-hongkong-c"  = one(module.ac-cn-hongkong-c[*].hosts)
    "aws-eu-central-1a" = one(module.aws-eu-central-1a[*].hosts)
    "do-eu-amsterdam3"  = one(module.do-eu-amsterdam3[*].hosts)
    "gc-us-central1-a"  = one(module.gc-us-central1-a[*].hosts)
  }
}
