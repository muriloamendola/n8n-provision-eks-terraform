# Learn how to create an EKS Cluster using Terraform and provision n8n tool

> This project was created for study purpose. I don't intend to turn it a production ready project.

The main challenge here is to create an IaC using Terraform, to provide a EKS cluster where we could run n8n tool. It's important to deal with scalability and security aspects.

The draft below ilustrates our project infrastructure and the modules and resource we must create using Terraform.
![Sample infrastructure we must create to provision n8n over EKS cluster.](./docs/project_infrastructure.png "Sample infrastructure we must create to provision n8n over EKS cluster.")

Looking to this image its clear that we have to create a VPC, and build our EKS cluster over private subnets. So we will need to use NAT Gateways and Internet Gateway to handle inbound and outbound traffic to our nodes.

Inside the folder `terraform-manifests` are all the .tf files to build our VPC, EKS and other resources.

## Tips

- I'm using VS Code as my IDE and installed HashiCorp Terraform plugin that help us with auto complete suggestions;
- To run terraform command in your machine you must install [Terraform CLI](https://developer.hashicorp.com/terraform/cli) or following the steps to run the project using docker containers;
- As we are using AWS as cloud provider its necessary to have an AWS account and [configured credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) with administrator privilege to create and manage resources;

## Running

Based on Terraform workflow below, we have some commands to plan and apply or destroy our managed infrastructure.

![Terraform workflow](./docs/terraform_workflow.png)

After install Terraform CLI and clone this repository, go to the folder terraform-manifests, then, run the following commands to apply changes in resources or create them:

```
terraform init
terraform plan
terraform apply -auto-approve
```

### Using Docker containers

If you wouldn't like to install Terraform CLI in your machine you can run using docker containers using the following commands.

Building container image
```
docker build --rm --tag muriloamendola/terraform-n8n:0.1 .
```

terraform apply
```
docker run --name tf-n8n muriloamendola/terraform-n8n:0.1 apply
```

terraform destroy
```
docker run --name tf-n8n muriloamendola/terraform-n8n:0.1 destroy
```

## Configure kubectl

After apply the configuration files you can configure `kubectl` to execute commands in your EKS Cluster.

To do this, run the command below replacing `region`` and `cluster_name` with the correct values

```
aws eks --region $(region) update-kubeconfig \
    --name $(cluster_name)
```

## Jobs to be done

- Configure RDS Postgres instance to be used by n8n;
- Create n8n manifests files to run over Kubernetes;
- Handle eks logs using CloudWatch;