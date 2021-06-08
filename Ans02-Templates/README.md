# Ansible-02  Terraform + Ansible Templates -DigitalOCean
## Requirements

- Modify the existing playbook (Ansible-01) as follows:

  - there should be a stage of copying the nginx.conf configuration file

  - there should be a stage of copying 2 config files for different virtualhosts

  - virtualhosts configuration must be in templates, not static files

  - virtualhosts configuration must be activated by creating a symlink in sites-enabled or placed in the conf.d directory.

- An nginx reload operation must be performed to apply the configuration changes.

- The solution must use templates
