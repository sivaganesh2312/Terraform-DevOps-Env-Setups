# ssh command
output "ssh-command" {
  value = "ssh learningthoughts@${azurerm_linux_virtual_machine.docker.public_ip_address}"
}

output "message" {
  value = "Please wait for atleast 3-4 minutes after the instance to be ready to ssh and use docker"
}