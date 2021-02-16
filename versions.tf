
terraform {
  required_version = ">= 0.13"
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = " = 1.95.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = " = 2.10.1"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = " = 2.5.1"
    }
    google = {
      source  = "hashicorp/google"
      version = " = 3.42.0"
    }
  }
}
