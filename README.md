# Description

This is a helper module used by Status internal repos like: [infra-hq](https://github.com/status-im/infra-hq), [infra-misc](https://github.com/status-im/infra-misc), [infra-eth-cluster](https://github.com/status-im/infra-eth-cluster), or [infra-swarm](https://github.com/status-im/infra-swarm).

It allows for use of the following three cloud providers via one module:
* [digital-ocean](https://github.com/status-im/infra-tf-digital-ocean)
* [google-cloud](https://github.com/status-im/infra-tf-google-cloud)
* [alibaba-cloud](https://github.com/status-im/infra-tf-alibaba-cloud)

# Usage

Simply import the module using the `source` directive:
```hcl
module "appx" {
  source     = "github.com/status-im/infra-tf-multi-provider"

  /* General */
  env   = "appx"
  stage = "prod"
  group = "appx-prod"

  /* Scaling */
  host_count = 2
  do_type    = "s-1vcpu-2gb"
  gc_type    = "n1-standard-1"
  ac_type   = "ecs.sn1ne.large"
  open_ports = ["1234", "2345-3456"]
}
```
Each cloud provider is optional and can be disabled by setting their respective `*_count` variable to `0`.

[More details.](https://www.terraform.io/docs/modules/sources.html#github)

# Variables

* __General__
  * `name` - Prefix of hostname before index. (default: `node`)
  * `env` - Environment for these hosts, affects DNS entries.
  * `stage` - Name of stage, like `prod`, `dev`, or `staging`.
  * `group` - Ansible group to assign hosts to.
* __Security__
  * `open_tcp_ports` - TCP ports to enable access from outside. (default: `[]`)
  * `open_udp_ports` - UDP ports to enable access from outside. (default: `[]`)
* __DNS__
  * `cf_zone_id` - CloudFlare DNS domain zone ID. (ID for `status.im`)
  * `domain` - DNS Domain for hostnames. (default: `status.im`)
* __Scaling__
  * `host_count` - Number of hosts to run. Overridden by individual provider counts.
  * __Alibaba Cloud__
    * `ac_count` - Number of Alibaba Cloud hosts to run.
    * `ac_type` - Type of host to provision in Alibaba Cloud. (default: `ecs.t5-lc1m1.small`)
    * `ac_root_vol_type` - Size in GiB of the host volume. (default: `15`)
    * `ac_root_vol_size` - I/O optimization type of extra data volume. (default: `cloud_efficiency`)
    * `ac_data_vol_type` - Size in GiB of extra volume for host. (default: `0`)
    * `ac_data_vol_size` - I/O optimization type of root volume. (default: `cloud_ssd`)
  * __Digital Ocean__
    * `do_count` - Number of Digital Ocean hosts to run.
    * `do_type` - Type of host to provision in Digital Ocean. (default: `s-1vcpu-1gb`)
    * `do_data_vol_size` - Size in GiB of extra volume for host. (default: `0`)
  * __Google Cloud__
    * `gc_count` - Number of Google Cloud hosts to run.
    * `gc_type` - Type of host to provision in Google Cloud. (default: `n1-standard-1`)
    * `gc_root_vol_size` - Size in GiB of the host volume. (default: `15`)
    * `gc_data_vol_size` - Size in GiB of the extra data volume. (default: `0`)
