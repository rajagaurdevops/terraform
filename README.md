# Azure AKS Deployment using Terraform

यह प्रोजेक्ट Azure Kubernetes Service (AKS) और Azure Container Registry (ACR) को Terraform के जरिए deploy करने के लिए बनाया गया है।  

यहाँ included resources हैं:  
- Resource Group  
- Virtual Network & Subnet  
- Log Analytics Workspace  
- Azure Container Registry (ACR)  
- AKS Cluster (RBAC, Managed Identity, Monitoring)  
- Role Assignment (AKS → ACR)  

---

## 🗂 Project Structure

aks/
├── main.tf # Resource definitions (RG, VNet, Subnet, ACR, AKS)
├── providers.tf # Terraform provider configuration
├── variables.tf # Input variables
├── terraform.tfvars # Environment-specific values
├── outputs.tf # Outputs (kubeconfig, aks_name, acr_login_server)




---

## ⚙ Prerequisites

- Terraform ≥ 1.0  
- Azure CLI  
- Access to an Azure subscription  

```bash
az login


1. Initialize Terraform
  terraform init

2. Validate Configuration
  terraform validate

3. Plan Deployment
  terraform plan -out=tfplan

4. Apply Deployment
terraform apply "tfplan"

📄 Outputs

kubeconfig
terraform output kube_config > kubeconfig.yaml
export KUBECONFIG=$(pwd)/kubeconfig.yaml
kubectl get nodes

AKS Name
terraform output aks_name

ACR Login Server
terraform output acr_login_server

image push
az acr login --name <ACR_NAME>
docker build -t <ACR_LOGIN_SERVER>/myapp:v1 .
docker push <ACR_LOGIN_SERVER>/myapp:v1
