# GitOps & Infrastructure as Code (Terraform + ArgoCD)

Un'infrastruttura dimostrativa basata sui principi **GitOps**, che combina il provisioning automatizzato tramite **Terraform** con la distribuzione continua gestita da **ArgoCD** su un cluster Kubernetes.

---

## 🏗️ Architettura del Progetto

Il repository adotta una netta separazione tra il codice di infrastruttura (IaC) e i manifest applicativi tracciati da ArgoCD:

```text
gitops-terraform-argocd/
├── terraform/                  # Bootstrap dell'infrastruttura con Terraform
│   ├── main.tf                 # Provider K8s/Helm e installazione automatica di ArgoCD
│   ├── variables.tf            # Parametri di configurazione
│   └── outputs.tf              # Output di stato
├── k8s-manifests/              # Manifest Kubernetes gestiti via GitOps
│   └── app/
│       ├── configmap.yaml      # Configurazioni applicative
│       ├── deployment.yaml     # Deployment con repliche e resource limits
│       └── service.yaml        # Servizio ClusterIP interno
└── argocd/                     # Configurazione delle risorse di ArgoCD
    └── application.yaml        # CRD Application (Collega Git al Cluster)
└── README.md


graph TD
    User([🌐 Developer / Git Push]) -->|Commit & Push| GitHub[📂 GitHub Repository]
    
    subgraph TerraformCluster [Infrastructure as Code]
        Tf[Terraform Apply] -->|Bootstraps| K8sCluster[☸️ Kubernetes Cluster]
        Tf -->|Deploys Helm Chart| ArgoInstall[🚀 ArgoCD Controller]
    end

    subgraph GitOpsWorkflow [GitOps Synchronization]
        ArgoInstall -->|Polls / Watches| GitHub
        ArgoInstall -->|Auto-Sync & Self-Heal| AppNamespace[📦 Namespace: demo-app]
    end