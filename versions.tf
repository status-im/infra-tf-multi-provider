
terraform {
  required_version = "> 1.3.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
    }
    alicloud = {

      source  = "aliyun/alicloud"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
    }
    google = {
      source  = "hashicorp/google"
    }
  }
}
