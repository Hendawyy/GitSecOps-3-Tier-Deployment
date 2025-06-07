# 🚀 GitSecOps 3-Tier Deployment on AWS (Terraform + EKS + GitOps)

This project provides a fully automated, GitOps-enabled CI/CD infrastructure using Terraform and Amazon EKS. It provisions a secure, scalable, and production-grade Kubernetes environment that deploys and manages a 3-tier application along with essential DevOps tools like Jenkins, ArgoCD, SonarQube, Prometheus, and Grafana.

---

## 📁 Project Structure

```

GitSecOps-3-Tier-Deployment/
├── Argo
│   ├── App.yaml
│   └── secrets.yaml
├── DevOps – Final Hands-On Project.pdf
├── Jenkins-Pipeline
│   ├── Jenkinsfile
│   └── PodTemplate.yaml
├── LICENSE
├── README.md
├── Requirements
│   ├── EKS Self Managed.jpeg
│   └── SelfManaged.png
└── Terraform
    ├── locals.tf
    ├── main.tf
    ├── modules
    │   ├── Argo
    │   │   ├── ArgoApp
    │   │   │   ├── argoApp.yaml.tpl
    │   │   │   └── secret.yaml
    │   │   ├── ArgoCD.tf
    │   │   ├── DeployArgo.tf
    │   │   ├── provider.tf
    │   │   ├── Values
    │   │   │   ├── argo-image-updater-values.yaml
    │   │   │   └── argo-values.yaml
    │   │   └── variables.tf
    │   ├── Bastion
    │   │   ├── data.tf
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   ├── CertManager
    │   │   ├── CertManager.tf
    │   │   ├── cert-man-cluster-issuer.tf
    │   │   ├── provider.tf
    │   │   └── variables.tf
    │   ├── EBS
    │   │   ├── ebs.tf
    │   │   └── variables.tf
    │   ├── ECR
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   ├── EKS
    │   │   ├── eks.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   ├── ESO
    │   │   ├── ESO-AWS-Secret-store.tf
    │   │   ├── ESO.tf
    │   │   ├── provider.tf
    │   │   └── variables.tf
    │   ├── IAM
    │   │   ├── ArgoImageUpdaterRole.tf
    │   │   ├── ebs_CSI_role.tf
    │   │   ├── eks-role.tf
    │   │   ├── eso-role.tf
    │   │   ├── jenkins-irsa-role.tf
    │   │   ├── Kaniko-role.tf
    │   │   ├── ng-role.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   ├── IngressController
    │   │   ├── nginx_ingress.tf
    │   │   ├── outputs.tf
    │   │   ├── Scripts
    │   │   │   └── get_lb_dns.sh
    │   │   └── variables.tf
    │   ├── Jenkins
    │   │   ├── ESO-Jenkins-External-Secret.tf
    │   │   ├── Jenkins.tf
    │   │   ├── jenkins-volumes.tf
    │   │   ├── kaniko-svc-acc.tf
    │   │   ├── outputs.tf
    │   │   ├── provider.tf
    │   │   ├── Values
    │   │   │   └── jenkins-values.yaml
    │   │   └── variables.tf
    │   ├── Keys
    │   │   ├── main.tf
    │   │   └── outputs.tf
    │   ├── Monitoring
    │   │   ├── ESO-Grafana-External-Secret.tf
    │   │   ├── grafana-volumes.tf
    │   │   ├── prometheus-volumes.tf
    │   │   ├── PromGraf.tf
    │   │   ├── provider.tf
    │   │   ├── Values
    │   │   │   └── monitoring-values.yaml
    │   │   └── variables.tf
    │   ├── Network
    │   │   ├── igw.tf
    │   │   ├── natgw.tf
    │   │   ├── outputs.tf
    │   │   ├── routes.tf
    │   │   ├── subnets.tf
    │   │   ├── variables.tf
    │   │   └── vpc.tf
    │   ├── NodeGroup
    │   │   ├── data-eks-addons.tf
    │   │   ├── eks-addons.tf
    │   │   ├── ManagedNodeGroup.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   ├── OIDC
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   ├── Scripts
    │   │   │   └── get-thumbprint.sh
    │   │   └── variables.tf
    │   ├── Route53
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   ├── SecGrp
    │   │   ├── Bastion.tf
    │   │   ├── Cluster.tf
    │   │   ├── default.tf
    │   │   ├── ingress.tf
    │   │   ├── NG.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   ├── SecretsManager
    │   │   ├── SecretManager.tf
    │   │   └── variables.tf
    │   └── SonarQube
    │       ├── provider.tf
    │       ├── SonarQube.tf
    │       ├── sonar-volumes.tf
    │       ├── Values
    │       │   └── sonarqube-values.yaml
    │       └── variables.tf
    ├── outputs.tf
    ├── providers.tf
    ├── Terraform.tf
    ├── terraform.tfstate
    ├── terraform.tfstate.1749479752.backup
    ├── terraform.tfstate.1749479758.backup
    ├── terraform.tfstate.backup
    ├── variables.tf
    └── vars.auto.tfvars

32 directories, 111 files

````

---

## ⚙️ What This Deploys

With a **single `terraform apply`**, the following infrastructure and tools are deployed:

### 🔐 Infrastructure
- VPC, subnets, route tables, NAT, IGW
- Secure bastion host for private access
- EKS Cluster with self-managed node group
- Route53 domain (e.g. `HendawyDevOps`) and subdomains
- OIDC provider + IRSA roles
- IAM roles for Jenkins, ArgoCD, ESO, Kaniko, etc.
- ECR repositories for app containers
- KMS keys and secure secrets with AWS Secrets Manager

### ⚙️ Platform Tools (via Helm)
- **ArgoCD**: GitOps controller for Kubernetes manifests
- **Jenkins**: CI/CD pipelines using Kaniko and ECR
- **SonarQube**: Code quality and security scanning
- **Trivy**: Docker image vulnerability scanning
- **Kaniko**: Build and push container images inside the Kubernetes cluster
- **Prometheus + Grafana**: Monitoring and visualization
- **Cert-Manager**: Auto TLS with Let’s Encrypt
- **Nginx Ingress Controller**: External access

### 🔒 Secrets & Storage
- ESO (External Secrets Operator) configured for syncing AWS secrets
- Persistent EBS volumes for Jenkins, SonarQube, Prometheus, Grafana
- GitOps-based secrets provisioning with external secret manifests

---

## 🚀 One-Command Deployment

All resources are provisioned and the full 3-tier application stack is deployed using a **single Terraform apply**.

### ✅ Run the Full Deployment

```bash
cd Terraform/
terraform init
terraform apply -var-file="vars.auto.tfvars"
````

> No manual `kubectl`, no Helm installations — everything is bootstrapped automatically. The CI/CD tools and application services are up and running post-deployment.

---

## 📦 CI/CD Pipeline

The `Jenkins-Pipeline/` directory contains:

* A `Jenkinsfile` that automates build, scan, push, and deploy stages.
* A custom `PodTemplate.yaml` to define Jenkins agent behavior inside Kubernetes.

---

## 🧠 Requirements

* AWS account with admin-level access
* Terraform CLI
* AWS CLI with credentials configured
* `kubectl` configured
* Helm CLI
* Route53 domain name (e.g., `HendawyDevOps`)

---

## 📸 Architecture Diagrams

See the `Requirements/` folder for JPEG and PNG architecture diagrams:

* EKS Managed cluster
* Service interconnections

---

## 🤝 Author

**Seif Hendawy**  
**∞** DevOps Engineer  
📍 *Cairo, Egypt*


## 📝 License

This project is licensed under the MIT License.


## 💬 Feedback

If you have any questions, suggestions, or need assistance, please don't hesitate to Contact Me on  [![LinkedIn](https://img.shields.io/badge/LinkedIn-blue?logo=linkedin&logoColor=white)](https://www.linkedin.com/in/seif-hendawy-3995561a8/).
