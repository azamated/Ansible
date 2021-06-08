# Init
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.7.0"
    }
  }
}


# Configure AWS and DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
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
