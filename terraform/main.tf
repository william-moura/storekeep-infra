terraform {
  required_version = ">= 1.5.0"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.0"
    }
  }
}

# Configuração de conexão SSH com a VPS existente
resource "null_resource" "server_setup" {
  connection {
    type        = "ssh"
    user        = var.ssh_user
    host        = var.vps_ip
    private_key = file(var.ssh_private_key_path)
  }

  # Atualizar pacotes e garantir Docker instalado
  provisioner "remote-exec" {
    inline = [
      "echo 'Atualizando sistema e garantindo Docker...'",
      "apt-get update -y",
      "apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
      "if ! command -v docker &> /dev/null; then curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh; fi",
      "apt-get install -y docker-compose-plugin",
      "mkdir -p /var/www/erp"
    ]
  }
}

output "server_status" {
  value = "Infraestrutura na VPS ${var.vps_ip} provisionada/configurada com sucesso para o domínio ${var.domain_name}!"
}