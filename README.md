# Description

This is a helper module used by Status internal repos like: [infra-hq](https://github.com/status-im/infra-hq), [infra-misc](https://github.com/status-im/infra-misc), [infra-eth-cluster](https://github.com/status-im/infra-eth-cluster), or [infra-swarm](https://github.com/status-im/infra-swarm).

It allows for use of the following three cloud providers via one module:
* [digital-ocean](https://github.com/status-im/infra-tf-digital-ocean)
* [google-cloud](https://github.com/status-im/infra-tf-google-cloud)
* [alibaba-cloud](https://github.com/status-im/infra-tf-alibaba-cloud)

# Usage

Simply import the modue using the `source` directive:
```hcl
module "widget" {
  source     = "github.com/status-im/infra-tf-multi-provider"
  count      = 2
  env        = "widget"
  group      = "widget"
  do_size    = "s-1vcpu-2gb"
  gc_size    = "n1-standard-1"
  ac_size    = "ecs.sn1ne.large"
  open_ports = ["1234-1234"]
}
```
[More details.](https://www.terraform.io/docs/modules/sources.html#github)

# Variables

* __General__
  * `name` - Prefix of hostname before index. (default: `node`)
  * `env` - Environment for these hosts, affects DNS entries.
  * `stage` - Name of stage, like `prod`, `dev`, or `staging`.
  * `group` - Ansible group to assign hosts to.
  * `domain` - DNS Domain to update
* __Scaling__
  * `count` - Number of hosts to run.
  * `do_size` - Size of host to provision in Digital Ocean. (default: `s-1vcpu-1gb`)
  * `gc_size` - Size of host to provision in Google Cloud. (default: `n1-standard-1`)
  * `ac_size` - Size of host to provision in Alibaba Cloud. (default: `ecs.t5-lc1m1.small`)
  * `ac_data_vol_size` - Size in GiB of extra volume for host. (default: `0`)
  * `do_data_vol_size` - Size in GiB of extra volume for host. (default: `0`)
  * `gc_data_vol_size` - Size in GiB of the extra data volume. (default: `0`)
  * `gc_rott_vol_size` - Size in GiB of the host volume. (default: `15`)
* __Security__
  * `open_tcp_ports` - TCP ports to enable access from outside. (default: `["80-80","443-443"]`)
  * `open_udp_ports` - UDP ports to enable access from outside. (default: `[]`)
