# 🚀 Amazon EKS Cluster Setup using Terraform

This project automates the creation of an **Amazon Elastic Kubernetes Service (EKS)** cluster using **Terraform**.  
It provisions all required AWS resources — including VPC, Subnets, Internet Gateway, Route Tables, IAM Roles, Security Groups, EKS Cluster, and Node Groups.

---

## 🧠 What is Amazon EKS?

**Amazon Elastic Kubernetes Service (EKS)** is a fully managed Kubernetes service provided by AWS.  
It allows you to run Kubernetes applications in the AWS cloud or on-premises without having to manage the Kubernetes control plane yourself.

EKS automatically handles:
- Kubernetes master node availability & scalability
- Security patches and updates
- Integration with AWS services (IAM, VPC, CloudWatch, ALB, etc.)

---

## 📋 Prerequisites

Before you start, ensure you have the following tools installed on your system:

| Tool | Minimum Version | Purpose |
|------|------------------|---------|
| [Terraform](https://developer.hashicorp.com/terraform/downloads) | v1.5+ | Infrastructure as Code |
| [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) | v2+ | Interact with AWS |
| [kubectl](https://kubernetes.io/docs/tasks/tools/) | Latest | Manage Kubernetes cluster |
| [eksctl (optional)](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html) | Latest | Additional EKS management |
| AWS Account | — | To deploy infrastructure |
| IAM User/Role with permissions | — | To provision resources |

---

## 🔑 Required IAM Permissions

The user executing Terraform must have **sufficient AWS IAM permissions** to create and manage EKS and its dependencies.

Minimum recommended policies:

- `AmazonEKSClusterPolicy`
- `AmazonEKSServicePolicy`
- `AmazonEKSWorkerNodePolicy`
- `AmazonEKS_CNI_Policy`
- `AmazonEC2ContainerRegistryReadOnly`
- `AmazonVPCFullAccess`
- `AmazonEC2FullAccess`
- `IAMFullAccess`
- `CloudWatchFullAccess`

> ⚠️ If your user **does not have these permissions**, Terraform will fail with `AccessDenied` or `UnauthorizedOperation` errors when creating resources such as IAM roles, EKS cluster, or EC2 nodes.

You can ask your AWS admin to attach these managed policies to your IAM user or role before running Terraform.

---


## 🚀 Steps to Deploy

Follow the steps below to deploy your EKS cluster using Terraform:

### 1️⃣ Initialize Terraform
Initialize the working directory that contains your Terraform configuration files.

```bash
terraform init
```

## 2️⃣ Validate Configuration
Check if your Terraform files are syntactically valid and consistent
```bash
terraform validate
```

3️⃣ Review the Execution Plan
Generate and review the execution plan to see what Terraform will create or modify.
```bash
terraform plan -var-file="variables.tfvars"
```

4️⃣ Apply the Configuration
Deploy the infrastructure by applying the Terraform configuration
```bash
terraform apply -var-file="variables.tfvars" -auto-approve
```

Terraform will:<br>
    Create the VPC and networking resources<br>
    Create IAM roles and attach necessary policies<br>
    Deploy the EKS cluster<br>
    Launch the worker node group<br>
    Configure networking and routing<br>


## ✅ Post Deployment
Once the Terraform deployment completes successfully, configure your kubectl to connect to the new EKS cluster:
```bash
aws eks update-kubeconfig --region ap-south-1 --name test-eks-cluster
```

## Verify the cluster connection and node status

```bash
kubectl get nodes
kubectl get pods -A
```

