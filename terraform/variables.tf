variable "proxmox_endpoint" {
  description = "Proxmox API endpoint"
  type        = string
}

variable "proxmox_api_token" {
  description = "Proxmox API token"
  type        = string
  sensitive   = true
}

variable "proxmox_password" {
  description = "Proxmox root password"
  type        = string
  sensitive   = true
}

variable "lxc_vmid" {
  description = "LXC VM ID"
  type        = number
}

variable "lxc_hostname" {
  description = "LXC hostname"
  type        = string
}

variable "lxc_ip" {
  description = "LXC IP address with CIDR"
  type        = string
}

variable "lxc_gateway" {
  description = "Network gateway"
  type        = string
}

variable "lxc_cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 1
}

variable "lxc_memory" {
  description = "RAM in MB"
  type        = number
  default     = 512
}

variable "lxc_disk" {
  description = "Disk size in GB"
  type        = number
  default     = 8
}
