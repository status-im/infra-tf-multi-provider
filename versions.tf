
terraform {
  required_version = "~> 1.3.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = " = 2.21.0"
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
