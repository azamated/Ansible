# Ansible-06  Terraform + Ansible templates + variables + Jinja2 + Roles + Auto Ceritifcates -- DigitalOCean
## Requirements

- Install Nginx and place the config for the virtual host

- Using ansible, describe the role for obtaining a certificate from Let's Encrypt for your domain.

- Place the certificate by tweaking the Nginx config.

- Configure auto-renewal of the certificate.

# NGINX ROLE
 
  - Installs the latest nginx build
 
  - Removes default nginx configuration

# APP-SRV ROLE
 
   - Creates virtualhost directory
 
   - Generates a virtul host configuration file from the template
  
   - Hostname is a variable

# CERT-LENCR  ROLE

  - TLS certificate for the host with auto renewal

