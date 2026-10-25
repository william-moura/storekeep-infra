variable "vps_ip" {
  description = "IP da VPS existente (caso já tenha a máquina criada) ou parâmetro do provedor"
  type        = string
}

variable "ssh_user" {
  type    = string
  default = "root"
}

variable "ssh_private_key_path" {
  type    = string
  default = "~/.ssh/id_rsa"
}

variable "domain_name" {
  type    = string
  default = "sysmanager.tech"
}