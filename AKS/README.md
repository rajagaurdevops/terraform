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

 ![AKS Integrations Tab](./azure-portal-kubernetes-integrations.jpg)

---

### 🔹 Step 3: Connecting to the AKS Cluster

#### 1️⃣ Install kubectl
- **Azure Cloud Shell:** Pre-installed  
- **Local machine:**  
  ```bash
  az aks install-cli
