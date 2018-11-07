# Description

This is a helper module used by Status internal repos like: [infra-hq](https://github.com/status-im/infra-hq), [infra-misc](https://github.com/status-im/infra-misc), [infra-eth-cluster](https://github.com/status-im/infra-eth-cluster), or [infra-swarm](https://github.com/status-im/infra-swarm).

# Usage

Simply import the modue using the `source` directive:
```hcl
module "multi-provider" {
  source = "github.com/status-im/infra-tf-multi-provider"
}
```

[More details.](https://www.terraform.io/docs/modules/sources.html#github)

# Variables

* __General__
  * `name` - Prefix of hostname before index. (default: `node`)
  * `env` - Environment for these hosts, affects DNS entries.
  * `group` - Ansible group to assign hosts to.
  * `domain` - DNS Domain to update
* __Scaling__
  * `count` - Number of hosts to run.
  * `do_size` - Size of host to provision in Digital Ocean. (default: `s-1vcpu-1gb`)
  * `gc_size` - Size of host to provision in Google Cloud. (default: `n1-standard-1`)
  * `ac_size` - Size of host to provision in Alibaba Cloud. (default: `ecs.t5-lc1m1.small`)
* __Security__
  * `open_ports` - TCP ports to enable access from outside. (default: `["80-80","443-443"]`)
