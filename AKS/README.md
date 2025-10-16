# 🚀 Azure Kubernetes Service (AKS) Setup Guide

## 📘 1. Introduction
**Azure Kubernetes Service (AKS)** is a managed Kubernetes service provided by **Microsoft Azure**.  
Azure manages the **Kubernetes Control Plane** (API Server, etcd, Scheduler, etc.), while you only manage the **Worker Nodes** and the applications running on them.

---

## ⚙️ 2. Prerequisites

Before starting, ensure you have the following:

- ✅ Active **Azure Subscription**  
- ✅ **Azure CLI** installed  
- ✅ **kubectl CLI** installed  
- ✅ *(Optional)* **Helm** installed  

---

## 💡 3. Why We Need AKS

**AKS** simplifies the deployment, management, and scaling of containerized applications in Azure by offloading the complexity of managing Kubernetes infrastructure to the cloud provider.

> 💬 **Example:** Without AKS, you would need to set up and maintain your own Kubernetes cluster on Azure VMs, handle scaling, and perform manual updates. AKS automates all of these.

---

## 🧭 4. AKS Cluster Setup Using Azure Portal

### 🔹 Step 1: Sign in to the Azure Portal

1. Go to [Azure Portal](https://portal.azure.com).  
2. Sign in with your **Azure Subscription** credentials.

---

### 🔹 Step 2: Create an AKS Cluster

1. On the Azure portal home page, click **Create a resource**  
2. Navigate to:  
   **Categories → Containers → Azure Kubernetes Service (AKS)**

#### **Basics Tab**
- **Subscription:** Select your Azure subscription  
- **Resource group:** Create new (e.g., `myResourceGroup`)  
- **Cluster preset configuration:** Select **Dev/Test**  
- **Kubernetes cluster name:** `myAKSCluster`  
- **Region:** `East US 2`  
- **Availability zones:** None  
- **AKS pricing tier:** Free  

> Leave default values and click **Next**

#### **Node Pools Tab**
- Click **Add node pool**  
  - **Node pool name:** `nodepool1`  
  - **Mode:** User  
  - **OS SKU:** Ubuntu Linux  
  - **Availability zones:** None  
  - **Node size:** `Standard_D2s_v3`  
- Click **Add**, then **Review + create**  
- Validate and click **Create**

<!-- Resized image using HTML -->
<img src="https://learn.microsoft.com/en-us/azure/aks/learn/media/quick-kubernetes-deploy-portal/create-cluster.png" width="500" alt="Create Kubernetes Cluster (Azure Portal)">

---
<!-- Resized image using HTML -->
<img src="https://learn.microsoft.com/en-us/azure/aks/learn/media/quick-kubernetes-deploy-portal/create-linux-node-pool.png" width="400" alt="Create Linux Node Pool (Azure Portal)">
---


### 🔹 Step 3: Connecting to the AKS Cluster

#### 1️⃣ Install kubectl
- **Azure Cloud Shell:** Pre-installed  
- **Local machine:**  
  ```bash
  az aks install-cli

# 🔐 3) Download Cluster Credentials
Use the following command to download and configure your cluster credentials

```bash
az aks get-credentials --resource-group myResourceGroup --name myAKSCluster
```

✅ This command merges your AKS cluster’s credentials into your local `~/.kube/config file`, allowing kubectl to communicate with your cluster.














# Azure Kubernetes Service (AKS) Setup Guide

## 1. Introduction
Azure Kubernetes Service (AKS) is a managed Kubernetes service provided by Microsoft Azure.  
Azure manages the Kubernetes Control Plane (API Server, etcd, Scheduler, etc.), while you only need to manage the Worker Nodes and the applications running on them.

---

## 2. Prerequisites
- Active Azure Subscription
- Azure CLI installed
- `kubectl` CLI installed
- (Optional) Helm installed

---

## 3. Why We Need AKS
AKS simplifies the deployment, management, and scaling of containerized applications in Azure by offloading the complexity of managing Kubernetes infrastructure to the cloud provider.  

**Example:** Without AKS, you would need to set up your own Kubernetes cluster on VMs and handle updates manually. AKS automates these tasks.

---

## 4. AKS Cluster Setup Using Azure Portal

### Step 1: Sign in to the Azure Portal
- Open [Azure Portal](https://portal.azure.com).
- Sign in with your Azure subscription credentials.

### Step 2: Create an AKS Cluster
1. On the Azure portal home page, select **Create a resource**.
2. Navigate to: **Categories → Containers → Azure Kubernetes Service (AKS)**.

#### Basics Tab
- **Subscription:** Select the Azure subscription.
- **Resource group:** Create new, e.g., `myResourceGroup`.
- **Cluster preset configuration:** Select `Dev/Test`.
- **Kubernetes cluster name:** e.g., `myAKSCluster`.
- **Region:** Select a region, e.g., `East US 2`.
- **Availability zones:** None.
- **AKS pricing tier:** Free.  
Leave default values and click **Next**.

#### Node Pools Tab
- **Add node pool:** Enter a Node pool name.
- **Mode:** User
- **OS SKU:** Ubuntu Linux
- **Availability zones:** None
- **Node size:** D2s_v3  
Leave default settings and click **Add**.

- Click **Review + create**, validate, and then **Create**.

### Step 3: Connecting to the AKS Cluster

#### 1) Using `kubectl`
`kubectl` is the Kubernetes command-line client used to manage Pods, Deployments, and Services.

#### 2) Install `kubectl`
- **Azure Cloud Shell:** pre-installed.
- **Local machine:**  
```bash
az aks install-cli

