# Create a new tag for module
resource "digitalocean_tag" "devops" {
  name = "devops"
}

# Create a new tag for email
resource "digitalocean_tag" "azamat_at_amirakulov_com" {
  name = "azamat_at_amirakulov_com"
}

# Create VPC
resource "digitalocean_droplet" "vpc-Ansible-06" {
  name     = "vpc-Ansible-06"
  size     = "s-1vcpu-1gb"
  image    = "ubuntu-18-04-x64"
  region   = "nyc3"
  ssh_keys = [digitalocean_ssh_key.local_pub_key.fingerprint, data.digitalocean_ssh_key.RELAB_SSH_PUB_KEY.id]
  tags = [digitalocean_tag.devops.id, digitalocean_tag.azamat_at_amirakulov_com.id]
}


# Get VPS data
data "digitalocean_droplet" "vpc-Ansible-06" {
  name = "vpc-Ansible-06"
  depends_on = [digitalocean_droplet.vpc-Ansible-06]
}

# Print public IP addresses
output "ip_address" {
  value = data.digitalocean_droplet.vpc-Ansible-06.ipv4_address
  }

# Save the valus of the public IP address on to a local variable
locals {
  public_ip = data.digitalocean_droplet.vpc-Ansible-06.ipv4_address
}

# Create AWS Route53 resource
resource "aws_route53_record" "web_srv" {
  zone_id = data.aws_route53_zone.lab_zone.zone_id
  name    = format("azamat-at-amirakulov-com.%s", data.aws_route53_zone.lab_zone.name)
  type    = "A"
  ttl     = "300"
  records = [local.public_ip]
}

# Render a yaml template file
data "template_file" "vps_yaml_inventory" {
  template = file("${path.module}/templates/yaml_inventory.tmpl")
  vars = {
     ip_addr = data.digitalocean_droplet.vpc-Ansible-06.ipv4_address
  }
}

# Generate a final file from the rendered template
resource "local_file" "ansible_yaml_inventory" {
  content  = data.template_file.vps_yaml_inventory.rendered
  filename = "${path.module}/inventory/ansible_inventory.yml"
}
