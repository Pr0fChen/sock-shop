[bastion]
{{ bastion_ip }}

[bastion:vars]
ansible_ssh_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/id_rsa
