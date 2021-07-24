locals {
  kubeconfig = abspath(pathexpand(var.kubeconfig))
}

resource "shell_script" "kubeconfig" {
  lifecycle_commands {
    create = "${var.command} &>/dev/null;\n${var.hash_command}"
    update = "${var.command} &>/dev/null;\n${var.hash_command}"
    read   = var.hash_command
    delete = "rm -f $KUBECONFIG"
  }

  environment = {
    KUBECONFIG   = local.kubeconfig
    CLUSTER_NAME = var.cluster_name
  }
}
