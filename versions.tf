
terraform {
  required_version = "~> 1.0.0"
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = " = 1.124.3"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = " = 2.21.0"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = " = 2.9.0"
    }
    google = {
      source  = "hashicorp/google"
      version = " = 3.73.0"
    }
  }
}
