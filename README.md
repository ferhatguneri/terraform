# AWS Development VM

Add 1 ubuntu 18 t3.micro instance

Configure Public key and private key for server

Add 1 security group which allows all traffic public ip of where terraform apply triggered

run shell script to install docker and docker-compose

# Installation

git clone https://github.com/ferhatguneri/terraform.git

cd terraform

Put your AK and SK into terraform.tfvars file.

terraform init

terraform apply
