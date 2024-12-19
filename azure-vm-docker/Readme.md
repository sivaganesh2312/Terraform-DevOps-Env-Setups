# Using this template

* Ensure Terraform is installed
* Ensure Azure CLI is installed and configure
* Ensure you have key pair generated using `ssh-keygen` command in your system
* Clone this repo and cd into `azure-vm-docker`
```
cd azure-vm-docker
terraform init
terraform apply -var "location=eastus" -var "vmsize=Standard_B1s" -var "resource_group_name=docker" -auto-approve
```
* Now wait till the execution and completed and look into outputs .Wait fr 2-3 minutes
* Now ssh into vm and start using docker
* Once your are done practicing destroy the instance
```
terraform destroy
```

*Enjoy your journey of learning docker*
