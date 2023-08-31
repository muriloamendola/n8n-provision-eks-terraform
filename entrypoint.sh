#!/bin/sh

terraform "$@"

if [ $# -eq 0 ]; then
  echo "No terraform command provided. exiting..."
  exit 1
fi

command=$1

case $1 in
    "init")
        terraform init
        ;;
    "plan")
        terraform init
        terraform plan -out out.tfplan 
        ;;
    "apply")
        terraform init
        terraform plan -out apply.tfplan 
        terraform apply -auto-approve apply.tfplan 
        ;;
    "destroy")
        terraform init
        terraform plan -destroy -out destroy.tfplan 
        terraform apply -auto-approve destroy.tfplan 
        ;;
    *)
        echo "Invalid command. available commands: init, plan, apply, destroy."
        ;;
esac