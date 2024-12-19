# output ssh command
output "ssh_command" {
  value = "ssh ubuntu@${aws_instance.docker.public_ip}"
}

output "message" {
    value = "Please wait for atleast 3-4 minutes after the instance to be ready to ssh and use docker"
}