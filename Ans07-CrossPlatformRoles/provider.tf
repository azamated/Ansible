#Init
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "1.22.2"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure AWS and DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

provider "aws" {
  region = "us-east-1"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

#Get RELAB SSH keys
data "digitalocean_ssh_key" "RELAB_SSH_PUB_KEY" {
  name = "RELAB.SSH.PUB.KEY"
}

#Create a resource for the local ssh key
resource "digitalocean_ssh_key" "local_pub_key" {
  name = "local_pub_key"
  public_key = var.local_pub_key
}

# Get Route53 zone data
data "aws_route53_zone" "lab_zone" {
  name = "devops.RELAB.srwx.net."
}
