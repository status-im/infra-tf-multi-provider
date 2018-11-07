output "public_ips" {
  value = [
    "${module.do-ams3.public_ips}",
    "${module.gc-us-central1-a.public_ips}",
    "${module.ac-cn-hongkong-c.public_ips}",
  ]
}
