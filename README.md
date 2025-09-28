📘 README.md — Deploy AKS with Terraform
📂 Project Structure
aks/
├── main.tf            # Azure resources (RG, VNet, Subnet, ACR, AKS, Role Assignment)
├── providers.tf       # Terraform + Provider settings
├── variables.tf       # Input variables
├── terraform.tfvars   # Environment-specific values
├── outputs.tf         # Useful outputs (kubeconfig, aks_name, acr_login_server)
⚙️ Prerequisites
Terraform v1.0+
Azure CLI
kubectl
Authenticate with Azure:
az login
az account set --subscription "<YOUR_SUBSCRIPTION_ID>"
🚀 Steps to Deploy
1. Initialize Terraform
terraform init
यह providers download करेगा और backend setup करेगा।
2. Preview the Plan
terraform plan -out plan.tfplan
यह दिखाएगा कि कौन से resources बनेंगे।
3. Apply Changes
terraform apply "plan.tfplan"
यह आपके Azure environment में resources बनाएगा:
Resource Group
Virtual Network + Subnet
Log Analytics Workspace
Azure Container Registry (ACR)
AKS Cluster (with optional Spot Node Pool)
Role Assignment (AKS → ACR pull)
🔑 Outputs
Apply के बाद useful outputs देखें:
terraform output
Export kubeconfig
terraform output kube_config > kubeconfig.yaml
export KUBECONFIG=./kubeconfig.yaml
Verify cluster:
kubectl get nodes
🐳 Working with ACR
Get the login server:
terraform output acr_login_server
# Example: acraksdemo001.azurecr.io
Login and push an image:
az acr login --name acraksdemo001
docker tag myapp:v1 acraksdemo001.azurecr.io/myapp:v1
docker push acraksdemo001.azurecr.io/myapp:v1
Now you can use this image inside your AKS cluster deployments.
🧹 Destroy Resources
जब resources की ज़रूरत न हो:
terraform destroy
📌 Notes
Subnet sizing: Azure CNI में हर Pod को VNet से IP मिलता है → ensure करें कि subnet में पर्याप्त IPs हों।
ACR name: globally unique और lowercase होना चाहिए।
Kubernetes version: हमेशा Azure-supported version दें (latest check करें az aks get-versions -l eastus)।
State file: Production में Terraform state को Azure Storage backend में रखें (remote backend)।
