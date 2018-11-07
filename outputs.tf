output "public_ips" {
  value = [
    "${module.do-ams3.public_ips}",
    "${module.gc-us-central1-a.public_ips}",
    "${module.ac-cn-hongkong-c.public_ips}"
  ]
}

output "hosts" {
  value = {
    "do-ams3"          = "${module.do-ams3.hosts}"
    "gc-us-central1-1" = "${module.gc-us-central1-a.hosts}"
    "ac-cn-hongkong-c" = "${module.ac-cn-hongkong-c.hosts}"
  }
}
