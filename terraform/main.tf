terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.78.0"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = var.proxmox_api_token
  username  = "root@pam"
  insecure  = true
  password  = var.proxmox_password
}

resource "proxmox_virtual_environment_container" "test_lxc" {
  node_name    = "pve"
  vm_id        = var.lxc_vmid
  description  = "LXC created with OpenTofu"
  unprivileged = true

  features {
    nesting = true
  }

  initialization {
    hostname = var.lxc_hostname

    ip_config {
      ipv4 {
        address = var.lxc_ip
        gateway = var.lxc_gateway
      }
    }

    user_account {
      keys     = [file("~/.ssh/id_ed25519.pub")]
    }
  }

  cpu {
    cores = var.lxc_cores
  }

  memory {
    dedicated = var.lxc_memory
  }

  disk {
    datastore_id = "flash"
    size         = var.lxc_disk
  }

  network_interface {
    name   = "eth0"
    bridge = "vmbr0"
  }

  operating_system {
    template_file_id = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
    type             = "ubuntu"
  }

  provisioner "local-exec" {
    command = <<EOT
      sleep 20 && \
      ansible-playbook -i '${split("/", var.lxc_ip)[0]},' \
      -u root \
      --private-key ~/.ssh/id_ed25519 \
      ../ansible/playbooks/hardening.yml
    EOT
  }

  provisioner "local-exec" {
    command = "echo '${split("/", var.lxc_ip)[0]} ${var.lxc_hostname}' | sudo tee -a /etc/hosts"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "sudo sed -i '/${self.initialization[0].hostname}/d' /etc/hosts"
  }
}

